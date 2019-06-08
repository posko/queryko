require 'spec_helper'

RSpec.describe Queryko::RangeAttributes do
  let(:query_object_class) do
    Class.new do
      include Queryko::FilterClasses
      include Queryko::RangeAttributes
      include Queryko::Filterer

      def defined_table_name
        'products'
      end

      def self.defined_table_name
        'products'
      end

      include Queryko::Able
      attr_accessor :params, :relation
      def initialize(params = {}, relation)
        @relation = relation
        @params = params
      end
      def call
        filter_by_filters
        relation
      end
      add_range_attributes :id
    end
  end

  describe 'anonymous class' do
    describe 'instance' do
      context '#range_attribute' do
        let(:query_instance) { query_object_class.new nil, nil}
        it "has range attributes :id" do
          expect(query_instance.fields.keys).to eq([:id_min, :id_max])

        end
      end

      context '#filter_range_attributes' do
        let(:products) do
          products = []
          5.times do |i|
            products << Product.create(name: "Sample #{i}")
          end
          products
        end

        it "filters attributes" do
          query = query_object_class.new({ id_min: products[3] }, Product.all)
          expect(query.call.count).to eq(2)
        end

        context "using min and max" do
          it "filters attributes" do
            query = query_object_class.new({ id_max: products[1]}, Product.all)
            expect(query.call.count).to eq(2)
          end
        end
      end
    end
  end
end
