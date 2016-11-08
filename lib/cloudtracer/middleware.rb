module Cloudtracer
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      header = env['HTTP_X_CLOUD_TRACE_CONTEXT']
      return @app.call unless header

      TraceContext.new(header).with_trace do
        @app.call(env)
      end
    end
  end
end
