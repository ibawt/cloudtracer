require 'thread'
require 'googleauth'

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
          self.class.service.patch_project_traces(config.project_id, trace)
        rescue StandardError => e
          logger.warn("Exception in TraceQueue: #{e.message}")
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
      OAUTH_SCOPES = %w(https://www.googleapis.com/auth/trace.append).freeze
      def service
        @service ||= begin
                      auth = Google::Auth.get_application_default(OAUTH_SCOPES)
                      s = Google::Apis::CloudtraceV1::CloudTraceService.new
                      s.authorization = auth
                      s
                    end
      end
    end
  end
end
