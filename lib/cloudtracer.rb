module Cloudtracer
  extend self

  def current_context
    Thread.current.thread_variable_get(:cloud_trace_context)
  end

  def current_context=(object)
    Thread.current.thread_variable_set(:cloud_trace_context, object)
  end

  def with_context(object)
    self.current_context = object
    yield
  ensure
    self.current_context = nil
  end

  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end
  end

  def logger=(logger)
    @logger = logger
  end

  def logger
    @logger ||= ActiveSupport::Logger.new(STDOUT)
  end
end

require 'cloudtracer/version'
require 'cloudtracer/error'
require 'cloudtracer/base'
require 'cloudtracer/config'
require 'cloudtracer/notifications'
require 'cloudtracer/middleware'
require 'cloudtracer/trace_context'
require 'cloudtracer/trace_queue'
require 'cloudtracer/railtie' if defined?(Rails)

if defined?(Redis)
  require 'cloudtracer/redis'
  Redis::Client.prepend(Cloudtracer::Redis)
end

require 'cloudtracer/http'
Net::HTTP.prepend(Cloudtracer::Http)
