require 'spec_helper'

RSpec.describe Queryko::Feature do
  let(:query_object) do
    OpenStruct.new defined_table_name: 'products'
  end

  let(:feature) do
    described_class.new feature_name, query_object
  end

  describe '#create_filter' do
    let(:feature_name) { 'created_at' }
    let(:options) { {filters: [:after] } }

    before { feature.create_filter(:after)}
    it 'creates filter' do
      expect(feature.filters[:after].column_name).to eq('created_at')
      expect(feature.filters[:after].table_name).to eq('products')
      expect(feature.filters[:after].class).to eq(Queryko::Filters::After)
      expect(feature.filters[:after].field).to eq('created_at_after')
    end
  end
end
