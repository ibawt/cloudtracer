require 'googleauth'
require 'google/apis/cloudtrace_v1'
require 'active_support'

module Cloudtracer
  extend self

  def logger=(logger)
    @logger = logger
  end

  def logger
    @logger ||= ActiveSupport::Logger.new(STDOUT)
  end
end

require 'cloudtracer/version'
require 'cloudtracer/base'
require 'cloudtracer/config'
require 'cloudtracer/notifications'
require 'cloudtracer/middleware'
require 'cloudtracer/service'
require 'cloudtracer/trace_context'
require 'cloudtracer/trace_queue'
require 'cloudtracer/railtie' if defined?(Rails)
