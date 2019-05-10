require 'spec_helper'

RSpec.describe Queryko::Searchables do
  let(:sample_class) do
    Class.new do
      include Queryko::Searchables

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
        # filter_by_searchables
        filter_by_filters
        relation
      end
      add_searchables :name
    end
  end

  describe 'anonymous class' do
    describe 'instance' do
      context "#filter_searchable" do
        it "filters attributes" do
          5.times do |i|
            Product.create(name: "Sample")
          end
          Product.create(name: 'Other')
          query = sample_class.new({ name: 'Sample' }, Product.all)

          expect(query.call.count).to eq(5)
        end
      end
    end
  end
end
