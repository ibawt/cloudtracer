require 'cloudtracer'

Cloudtracer.configure do |config|
  config.blacklist_controllers << 'PingController'
  config.project_id = 'cloudtracer-dummy-project'
end
