require 'spec_helper'

RSpec.describe Queryko::Filters::Base do
  let(:query_object) do
    OpenStruct.new defined_table_name: 'users'
  end

  let(:feature) do
    OpenStruct.new query_object: query_object
  end

  let(:options) do
    {
      column_name: 'name',
      as: 'fullname'
    }
  end
  let(:filter_class) do
    Class.new(described_class) do
      def initialize(options = {}, feature)
        super options, feature
      end
    end
  end

  let(:filter) { filter_class.new(options, feature) }

  it { expect(filter.table_name).to eq('users') }
  it { expect(filter.column_name).to eq('name') }
  it { expect(filter.as).to eq('fullname') }
end
