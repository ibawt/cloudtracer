class TestTraceQueue
  class << self
    def queue
      @queue ||= []
    end

    def reset!
      @queue = []
    end
  end

  def push(trace)
    self.class.queue.push trace
  end
end
