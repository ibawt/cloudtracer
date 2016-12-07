require 'cloudtracer'
require 'test_trace_queue'

Cloudtracer.configure do |config|
  config.blacklist_controllers << 'PingController'
  config.project_id = 'dummy-project'
  config.queue_adapter = TestTraceQueue
end
