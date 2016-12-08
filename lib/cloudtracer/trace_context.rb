require 'google/apis/cloudtrace_v1'

module Cloudtracer
  class TraceContext < Base
    MIDDLEWARE_SPAN = 'Cloudtracer::Middleware'.freeze

    attr_accessor :traces
    attr_reader :parent_span_id
    attr_accessor :span_id, :trace_id
    attr_accessor :trace

    def initialize(ctx)
      @trace_id, @parent_span_id, @trace_options = parse_header(ctx)
      @span_id = parent_span_id + 1

      @trace = Google::Apis::CloudtraceV1::Trace.new(
        trace_id: trace_id,
        project_id: config.project_id,
        spans: []
      )

      @traces = Google::Apis::CloudtraceV1::Traces.new(traces: [trace])
    end

    def with_trace(&_block)
      t1 = Time.now
      begin
        Thread.current.thread_variable_set(:cloud_trace_context, self)
        yield if block_given?
      ensure
        t2 = Time.now

        span = Google::Apis::CloudtraceV1::TraceSpan.new(
          name: MIDDLEWARE_SPAN,
          span_id: next_span_id,
          parent_span_id: parent_span_id,
          start_time:  t1,
          end_time: t2,
          labels: {}
        )
        trace.spans << span

        Thread.current.thread_variable_set(:cloud_trace_context, nil)

        trace_queue.push(traces)
      end
    end

    def update(span)
      span.parent_span_id = parent_span_id
      span.span_id = next_span_id
      trace.spans << span
    end

    private

    def parse_header(ctx)
      m = %r{(\w+)/(\d+);*(.*)}.match(ctx)
      return [m[1], Integer(m[2]), m.length > 2 ? m[3] : ''] if m
      raise Error, "Invalid Trace Context: #{ctx}"
    end

    def trace_queue
      self.class.trace_queue
    end

    def next_span_id
      self.span_id += 1
    end

    class << self
      def trace_queue
        @trace_queue ||= begin
                           if Cloudtracer.config.queue_adapter
                             Cloudtracer.config.queue_adapter.new
                           else
                             TraceQueue.new
                           end
                         end
      end
    end
  end
end
