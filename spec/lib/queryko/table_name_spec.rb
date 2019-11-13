require 'spec_helper'

RSpec.describe Queryko::Base do
  let(:application_query) do
    Class.new(described_class) do
      def self.name
        "ApplicationQuery"
      end
      feature :id, :min
      feature :id, :max
      feature :created_at, :min
      feature :created_at, :max
      feature :name, :search, as: :name
      feature :paginate, :paginate, upper: 100, lower: 2
    end
  end

  let(:products_query) do
    Class.new(application_query) do
      def self.name
        "ProductsQuery"
      end

      default_param :paginate, true
      default_param :limit, 10
      feature :id, :search, as: :id, cond: :eq
    end
  end

  let(:accounts_query) do
    Class.new(application_query) do
      def self.name
        "AccountsQuery"
      end
      default_param :paginate, true
      default_param :limit, 10
      feature :id, :search, as: :id, cond: :eq
    end
  end

  let(:accounts) do
    accounts =  []
    3.times do |i|
      accounts << Account.create(name: "Sample#{i}")
    end
    accounts
  end

  let(:params) { {} }

  before {
    products
    accounts
  }

  describe 'naming' do
    let(:params) { { name: 'Sample1' } }

    it { expect(accounts_query.new(params).call.count).to eq(1) }
    it { expect(products_query.new(params).call.count).to eq(1) }
  end

  describe 'table_name' do
    let(:params) { { id: accounts[0].id } }
    it 'correctly infers table_name' do
      expected = /(accounts.id = #{accounts[0].id})/
      products_query.new(params).perform.to_sql
      a_query = accounts_query.new(params).perform.to_sql
      expect(a_query).to match(expected)
    end
  end

  context 'without passing resource' do
    it { expect(products_query.new(params).call.count).to eq(3) }
    it { expect(products_query.table_name).to eq('products') }
    it { expect(products_query.model_class).to eq(Product) }
  end
end
