module Cloudtracer
  extend self

  def start_trace_context(ctx)
    Thread.current.thread_variable_set(:cloud_trace_context, ctx)
  end

  def current_context
    Thread.current.thread_variable_get(:cloud_trace_context)
  end

  def end_trace_context
    ctx = Thread.current.thread_variable_get(:cloud_trace_context)
    Thread.current.thread_variable_set(:cloud_trace_context, nil)

    trace_queue.push(ctx.traces)
  end

  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield @config
    end

    def trace_queue
      @trace_queue ||= TraceQueue.new
    end
  end
end
