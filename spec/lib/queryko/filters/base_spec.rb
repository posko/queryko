require 'spec_helper'

RSpec.describe Queryko::Filters::Base do
  let(:feature) { double('feature') }
  let(:options) do
    {
      table_name: 'users',
      column_name: 'name'
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
end
