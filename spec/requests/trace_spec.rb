require 'rails_helper'

RSpec.describe 'CloudTrace Integration', type: :request do
  describe 'middleware headers' do
    before do
      TestTraceQueue.reset!
    end

    it 'shouldnt trace if theres no header' do
      get '/'
      expect(TestTraceQueue.queue).to be_empty
    end
  end
end
