require 'rails_helper'

RSpec.describe 'Integration tests', type: :request do
  describe 'middleware' do
    before do
      TestTraceQueue.reset!
    end

    it 'shouldnt trace if theres no header' do
      get '/'
      expect(TestTraceQueue.queue).to be_empty
    end

    let(:invalid_header) { { 'X-Cloud-Trace-Context' => 'invalid' } }
    let(:valid_header) { { 'X-Cloud-Trace-Context' => 'deadbeef/foobar;extra_stuff' } }

    it 'should raise if the header is malfomed' do
      expect { get '/', headers: invalid_header }.to raise_error(Cloudtracer::Error)
    end

    it 'should produce a trace witha  valid header' do
      get '/', headers: valid_header
      expect(TestTraceQueue.queue).to_not be_empty
    end
  end
end
