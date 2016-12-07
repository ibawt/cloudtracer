module Cloudtracer
  class Config
    attr_accessor :project_id, :blacklist_controllers, :blacklist_topics, :extra_topics
    attr_accessor :queue_adapter

    def initialize
      @blacklist_controllers = []
      @blacklist_topics = []
      @extra_topics = []
    end
  end
end
