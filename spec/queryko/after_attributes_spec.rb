require 'spec_helper'

RSpec.describe Queryko::AfterAttributes do
  let(:query_object_class) {
    Class.new do
      include Queryko::AfterAttributes
      attr_accessor :params, :relation
      def initialize(params = {}, relation)
        @relation = relation
        @params = params
      end
      def call
        filter_after_attributes
      end
      add_after_attributes :id

      def defined_table_name
        'products'
      end
    end
  }

  describe 'anonymous class' do
    describe 'subclass' do
      let(:query_object_subclass) {
        Class.new(query_object_class) do
          add_after_attributes :subclass_id
        end
      }
      let(:query_subclass) { query_object_subclass }
      it "has after attributes :id" do
        expect(query_subclass.after_attributes.first).to eq(:id)
        expect(query_subclass.after_attributes.last).to eq(:subclass_id)
      end
    end

    describe 'instance' do
      let(:query_instance) { query_object_class.new nil, nil }
      context "#after_attributes" do
        it "has after attributes :id" do
          expect(query_instance.after_attributes.first).to eq(:id)
        end

        it "doesn't override after_attributes" do
          expect{ query_instance.after_attributes = [:hello] }.to raise_error(NoMethodError)
        end
      end

      context '#filter_after_attributes' do
        it "filtes attributes" do
          products =  []
          5.times do |i|
            products << Product.create(name: "Sample #{i}")
          end
          query = query_object_class.new({ after_id: products[1].id }, Product.all)
          expect(query.call.count).to eq(1)
        end
      end
    end
  end

  describe 'included' do
    context "with attributeless class" do
      let(:attributeless_class) {
        Class.new do
          include Queryko::AfterAttributes
        end
      }
      it "is working well" do
        object = attributeless_class.new
        expect(object.after_attributes).to eq([])
      end
    end
  end

end
