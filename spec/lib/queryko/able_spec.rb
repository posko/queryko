require 'spec_helper'

RSpec.describe Queryko::Able do
  let(:query_object_class) {
    Class.new do
      include Queryko::Able
      def self.defined_table_name
        'products'
      end

      feature :created_at, :search, cond: :like, token_format: '%token%'
      feature :created_at, :min
      feature :updated_at, :max
    end
  }
  describe do
    let(:query_object) { query_object_class.new }

    it { expect(query_object.features.count).to eq(2) }
    it { expect(query_object.features.keys).to eq([:created_at, :updated_at]) }
    it { expect(query_object.filters.count).to eq(3) }
    it { expect(query_object.filters.keys).to eq([:search, :min, :max]) }
    it { expect(query_object.fields.keys).to eq([:created_at_search, :created_at_min, :updated_at_max]) }
    it { expect(query_object.features[:created_at].filters.count).to eq(2) }
    it { expect(query_object.fields[:created_at_min].first.class).to eq(Queryko::Filters::Min) }
  end

  describe 'included' do
    context "with attributeless class" do
      let(:attributeless_class) {
        Class.new do
          include Queryko::Able
        end
      }

      it "is has default attributes" do
        object = attributeless_class.new
        expect(object.filters).to eq({})
        expect(object.features).to eq({})
        expect(object.fields).to eq({})
      end
    end
  end

end
