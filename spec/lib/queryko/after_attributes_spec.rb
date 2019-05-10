require 'spec_helper'

RSpec.describe Queryko::AfterAttributes do
  let(:query_object_class) {
    Class.new do
      include Queryko::AfterAttributes
      def defined_table_name
        'products'
      end

      def self.defined_table_name
        'products'
      end

      include Queryko::Able
      include Queryko::Filterer
      attr_accessor :params, :relation
      def initialize(params = {}, relation)
        @relation = relation
        @params = params
      end
      def call
        filter_by_filters
        relation
      end
      add_after_attributes :id

      def defined_table_name
        'products'
      end
    end
  }

  describe 'anonymous class' do
    describe 'instance' do
      let(:query_instance) { query_object_class.new nil, nil }

      context '#filter_after_attributes' do
        it "filtes attributes" do
          products =  []
          5.times do |i|
            products << Product.create(name: "Sample #{i}")
          end
          query = query_object_class.new({ after_id: products[1].id }, Product.all)
          expect(query.call.count).to eq(3)
        end
      end
    end
  end
end
