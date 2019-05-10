require 'spec_helper'

RSpec.describe Queryko::Naming do
  let(:query_object_class) {
    Class.new do
      def self.name
        'ProductsQuery'
      end
      include Queryko::Naming
    end
  }

  describe 'anonymous class' do
    describe 'subclass' do
      let(:query_object_subclass) {
        Class.new(query_object_class) do
          table_name :super_table
        end
      }
      let(:query_subclass) { query_object_subclass }
      it "has after table_name" do
        expect(query_subclass.table_name).to eq('super_table')
      end
    end

    describe 'instance' do
      let(:query_instance) { query_object_class.new }
      context "naming" do
        it "has table_name" do
          expect(query_instance.table_name).to eq("products")
        end

        it "doesn't override table_name" do
          expect{ query_instance.table_name = :hello }.to raise_error(NoMethodError)
        end

        it "doesn't override table_name" do
          expect{ query_instance.table_name = :hello }.to raise_error(NoMethodError)
        end
      end
    end
  end
end
