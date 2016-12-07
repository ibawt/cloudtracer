module Cloudtracer
  class Middleware < Base
    HEADER = 'HTTP_X_CLOUD_TRACE_CONTEXT'.freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      header = env[HEADER]
      return @app.call(env) unless header

      TraceContext.new(header).with_trace do
        @app.call(env)
      end
    end
  end
end
