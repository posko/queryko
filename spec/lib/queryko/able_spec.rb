require 'spec_helper'

RSpec.describe Queryko::Able do
  let(:query_object_base_class) do
    Class.new do
      include Queryko::Able
      include Queryko::FilterClasses
      def self.defined_table_name
        'products'
      end
    end
  end

  let(:query_object_class) do
    Class.new(query_object_base_class) do
      feature :created_at, :search, cond: :like, token_format: '%token%'
      feature :created_at, :min
      default_param :param1, 1
    end
  end

  let(:query_object_class2) do
    Class.new(query_object_class) do
      feature :updated_at, :max
      default_param :param2, 2
    end
  end

  let(:query_object_class3) do
    Class.new(query_object_class2) do
      default_param :param2, 3
      default_param :param3, 3
    end
  end

  describe '2nd degree inheritance' do
    let(:query_object) { query_object_class.new }
    let(:query_object2) { query_object_class2.new }
    let(:query_object3) { query_object_class3.new }

    it 'has correct features' do
      expect(query_object.features.count).to eq(1)
      expect(query_object2.features.count).to eq(2)
      expect(query_object3.features.count).to eq(2)
    end

    it 'has correct default_params' do
      expect(query_object.default_params).to eq({param1: 1})
      expect(query_object2.default_params).to eq({param1: 1, param2: 2})
      expect(query_object3.default_params).to eq({param1: 1, param2: 3, param3: 3})

      expect(query_object.default_params.count).to eq(1)
      expect(query_object2.default_params.count).to eq(2)
      expect(query_object3.default_params.count).to eq(3)
    end
  end

  # describe do
  #   let(:query_object) { query_object_class.new }
  #
  #   it { expect(query_object.features.count).to eq(2) }
  #   it { expect(query_object.features.keys).to eq([:created_at, :updated_at]) }
  #   it { expect(query_object.defined_filters.count).to eq(3) }
  #   it { expect(query_object.defined_filters.keys).to eq([:search, :min, :max]) }
  #   it { expect(query_object.fields.keys).to eq([:created_at_search, :created_at_min, :updated_at_max]) }
  #   it { expect(query_object.features[:created_at].filter_names.count).to eq(2) }
  #   it { expect(query_object.fields[:created_at_min].first.class).to eq(Queryko::Filters::Min) }
  # end
  #
  # describe 'included' do
  #   context "with attributeless class" do
  #     let(:attributeless_class) {
  #       Class.new do
  #         include Queryko::Able
  #         include Queryko::FilterClasses
  #       end
  #     }
  #
  #     it "is has default attributes" do
  #       object = attributeless_class.new
  #       expect(object.defined_filters).to eq({})
  #       expect(object.features).to eq({})
  #       expect(object.fields).to eq({})
  #     end
  #   end
  # end
end
