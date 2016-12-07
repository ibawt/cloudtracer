module Cloudtracer
  module Redis
    def call(command)
      ActiveSupport::Notifications.instrument('redis.call', command: command) do
        super
      end
    end
  end
end
