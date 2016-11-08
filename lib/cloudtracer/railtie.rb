require 'rails'

module Cloudtracer
  class Railtie < Rails::Railtie
    initializer 'cloudtracer.configure_rails_initializer' do
      Rails.application.middleware.use Cloudtracer::Middleware
      Cloudtracer::Notifications.register!
      Cloudtracer.logger = Rails.logger
    end
  end
end
