module Cloudtracer
  class Base
    protected

    def logger
      Cloudtracer.logger
    end

    def config
      Cloudtracer.config
    end
  end
end
