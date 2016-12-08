require 'rails_helper'

RSpec.describe Cloudtracer::TraceContext do
  let(:parent_span_id) { 4243223999123121 }
  let(:trace_id) { 'dadfadsfsfa3232' }
  let(:tracer) { Cloudtracer::TraceContext.new("#{trace_id}/#{parent_span_id};other_stuff") }

  before(:each) do
    TestTraceQueue.reset!
  end

  describe 'header parsing' do
    it 'parses the span_id correctly' do
      expect(tracer.parent_span_id).to eq(parent_span_id)
      expect(tracer.trace_id).to eq(trace_id)
    end

    it 'should set span_id to +1 of the parent_span_id' do
      expect(tracer.span_id).to be > parent_span_id
    end
  end

  describe 'with_trace' do
    let(:trace) do
      t1 = Time.now
      Timecop.freeze(t1) do
        tracer.with_trace do
          Timecop.travel(t1 + 1.seconds)
        end
      end
      TestTraceQueue.queue[0]
    end

    it 'should have the project id' do
      expect(trace.traces[0].project_id).to eq('dummy-project')
    end

    it 'should have the trace id' do
      expect(trace.traces[0].trace_id).to eq(trace_id)
    end

    it 'should have the middleware span in it' do
      mw_span = trace.traces[0].spans.find { |s| s.name == 'Cloudtracer::Middleware' }
      expect(mw_span.end_time.to_i - mw_span.start_time.to_i).to eq(1.second)
      expect(mw_span.span_id).to be > parent_span_id
    end
  end
end
