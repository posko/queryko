require 'spec_helper'

RSpec.describe Queryko::Naming do
  class NamesParentQuery
    include Queryko::Naming

    def self.inherited(subclass)
      table_name inferred_from_class_name(subclass)
    end
  end

  class NamesQuery < NamesParentQuery
  end

  describe 'anonymous class' do
    describe 'subclass' do
      it "has after table_name" do
        expect(NamesQuery.table_name).to eq('names')
      end
    end

    describe 'instance' do
      let(:query_instance) { NamesQuery.new }
      context "naming" do
        it "has table_name" do
          expect(query_instance.table_name).to eq("names")
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
