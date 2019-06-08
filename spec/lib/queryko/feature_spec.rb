require 'spec_helper'

RSpec.describe Queryko::Feature do
  let(:query_object) do
    # struct = OpenStruct.new defined_table_name: 'products'
    Class.new do
      include Queryko::FilterClasses
      def defined_table_name
        'products'
      end
    end
    .new
  end

  let(:feature) do
    described_class.new feature_name, query_object
  end

  it { puts "#{query_object.filters[:min]}" }
  describe '#create_filter' do
    let(:feature_name) { 'created_at' }
    let(:options) { {filters: [:after] } }

    before do
      feature.add_filter(:after)
      feature.add_filter(:before)
    end

    it 'creates filter' do
      expect(feature.filter_names[:after].column_name).to eq('created_at')
      expect(feature.filter_names[:after].table_name).to eq('products')
      expect(feature.filter_names[:after].class).to eq(Queryko::Filters::After)
      expect(feature.filter_names[:after].field).to eq('created_at_after')
      expect(feature.filter_names.count).to eq(2)
    end
  end
end
