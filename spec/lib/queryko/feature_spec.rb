require 'spec_helper'

RSpec.describe Queryko::Feature do
  let(:query_object) { double('query_object', defined_table_name: 'products') }
  let(:feature) do
    described_class.new feature_name, query_object
  end

  describe 'adding new feature' do
    let(:feature_name) { 'created_at' }
    let(:options) { {filters: [:after] } }

    before { feature.add_filter(:after)}
    it { expect(feature.filters[:after].count).to eq(1) }
  end
end
