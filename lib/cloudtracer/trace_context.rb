module Cloudtracer
  class TraceContext
    attr_accessor :traces
    attr_reader :parent_span_id
    attr_accessor :span_id, :trace_id
    attr_accessor :trace

    def initialize(ctx, project_id)
      if m = %r{(.*)/(.*);*(.*)}.match(ctx)
        @parent_span_id = m[2].to_i
        @trace_id = m[1]
        @trace_options = m[3] if m.length > 2
        @span_id = parent_span_id + 1

        @trace = Google::Apis::CloudtraceV1::Trace.new(
          trace_id: trace_id,
          project_id: project_id,
          span: []
        )

        @traces = Google::Apis::CloudtraceV1::Traces.new(traces: [trace])
      else
        raise Error "Invalid Trace Context: #{ctx}"
      end
    end

    def with_trace(&block)
      Cloudtracer.start_trace_context(tc)
      yield block
    ensure
      Cloudtracer.end_trace_context(tc)
    end

    def update(span)
      span.parent_id = parent_id
      span.span_id = next_span_id
      trace.spans << span
    end

    private

    def next_span_id
      self.span_id += 1
    end
  end
end
