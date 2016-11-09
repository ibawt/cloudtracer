require 'cloudtracer'

Cloudtracer.configure do |config|
  config.blacklist_controllers << 'PingController'
  config.project_id = 'shopify-core-alpha-1239'
end
