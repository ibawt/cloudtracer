module Cloudtracer
  class Config
    attr_accessor :project_id, :blacklist_controllers, :blacklist_topics

    def initialize
      self.blacklist_controllers = []
      self.blacklist_topics = []
    end
  end
end
