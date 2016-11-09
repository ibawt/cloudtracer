require 'thread'

module Cloudtracer
  class TraceQueue < Base
    def initialize
      @thread = Thread.new do
        work
      end
    end

    def work
      loop do
        begin
          trace = queue.pop
          Rails.logger.info("Sending a trace!")
          service.patch_project_traces(config.project_id, trace)
        rescue Google::Apis::Error => e
          logger.warn("Exception in TraceQueue: #{e.message}: #{e.body}")
        end
      end
    end

    def push(trace)
      queue.push trace
    end

    def close!
      @thread.kill
    end

    private

    def queue
      @queue ||= Queue.new
    end

    class << self
      private

      def service
        @servce ||= begin
                      scope = ['https://www.googleapis.com/auth/trace.append']
                      auth = Google::Auth.get_application_default(scope)

                      s = Google::Apis::CloudtraceV1::CloudTraceServer.new
                      s.authorization = auth
                    end
      end
    end
  end
end
