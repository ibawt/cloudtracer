require 'rails'

module Cloudtracer
  class Railtie < Rails::Railtie
    initializer 'cloudtracer.configure_rails_initializer' do
      Rails.application.middleware.insert_before Rack::Sendfile, Cloudtracer::Middleware
      Cloudtracer::Notifications.register!
      Cloudtracer.logger = Rails.logger
    end
  end
end
