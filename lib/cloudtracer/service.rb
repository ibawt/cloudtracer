module Cloudtracer
  extend self

  def current_context
    Thread.current.thread_variable_get(:cloud_trace_context)
  end

  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end

  end
end
