module Cloudtracer
  module Http
    def request(*args, &block)
      ActiveSupport::Notifications.instrument('net::http') do
        super
      end
    end
  end
end
