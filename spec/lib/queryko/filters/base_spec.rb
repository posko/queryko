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
      column_name: 'fullname'
    }
  end
  let(:filter_class) do
    Class.new(described_class) do
      # Simulating a defined Constant
      def self.name
        'Match'
      end
    end
  end

  let(:filter) { filter_class.new(options, feature) }

  # it { expect(filter.table_name).to eq('users') }
  it { expect(filter.field).to eq('fullname_match') }
  it { expect(filter.column_name).to eq('fullname') }
  it { expect(filter.as).to eq(nil) }

  context 'when overriding field name' do
    let(:options) do
      {
        column_name: 'name',
        as: 'name'
      }
    end

    it { expect(filter.as).to eq('name') }
    it { expect(filter.field).to eq('name') }
  end

  context 'with custom param key format' do
    let(:filter_class) do
      Class.new(described_class) do
        # Simulating a defined Constant
        def self.name
          'Match'
        end
        def param_key_format
          "#{parameterized_name}_#{column_name}"
        end
      end
    end

    it { expect(filter.field).to eq('match_fullname') }
  end
end
