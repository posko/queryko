require 'spec_helper'

RSpec.describe Queryko::Base do
  class ProductsQuery < Queryko::Base
    feature :id, :min
    feature :id, :max
    feature :created_at, :min
    feature :created_at, :max
    feature :name, :search, as: :name
    feature :paginate, :paginate, upper: 100, lower: 2

    default :paginate, true
    default :limit, 10
  end

  let(:products) do
    products =  []
    3.times do |i|
      products << Product.create(name: "Sample#{i}")
    end
    products
  end
  let(:params) { {} }
  let(:query) { ProductsQuery.new params, Product.all }

  before { products }


  context 'without passing resource' do
    it { expect(ProductsQuery.new(params).call.count).to eq(3) }
    it { expect(ProductsQuery.table_name).to eq('products') }
    it { expect(ProductsQuery.model_class).to eq(Product) }
  end

  describe 'defaults' do
    it { expect(ProductsQuery.defaults).to eq({limit: 10, paginate: true}) }
  end

  describe '#call' do
    let(:params) do
      {
        id_min: products[1].id
      }
    end

    it "filters query with params" do
      expect(query.count).to eq(2)
    end
  end

  describe '#count' do
    it { expect(query.count).to eq(3) }
  end

  context 'using limit' do
    let(:params) { { limit: 2, page: 1} }

    it "filters query" do
      expect(query.count).to eq(2)
    end
  end

  context 'with page' do
    context "1" do
      let(:params) { { limit: 2, page: 1} }
      it "returns first page" do
        expect(query.count).to eq(2)
        expect(query.total_count).to eq(3)
      end
    end

    context "1" do
      let(:params) { { limit: 2, page: 2} }
      it "returns first page" do
        expect(query.count).to eq(1)
      end
    end
  end

  describe 'total_count' do
    let(:params) { { limit: 2, page: 1} }
    context "when invoking count and total_count" do
      it "counts resource" do
        expect(query.count).to eq(2)
        expect(query.total_count).to eq(3)
        expect(query.count).to eq(2)
        expect(query.total_count).to eq(3)
      end
    end

    context "when invoking count only" do
      it { expect(query.count).to eq(2) }
    end

    context "when invoking total_count only" do
      it { expect(query.total_count).to eq(3) }
    end
  end

  context "using range_attribute" do
    let(:product0) { Product.create(name: 'Secret Product') }
    let(:product1) { Product.create(name: 'Milk') }
    let(:product2) { Product.create(name: 'Bread') }
    before do
      product0
      product1
      product2
    end
    it "returns list of products" do
      q = ProductsQuery.new({ id_min: product1.id }, Product.all)
      expect(q.count).to eq(2)
    end

    it "returns list of products" do
      q = ProductsQuery.new({ id_max: product1.id + 1 }, Product.all)
      expect(q.count).to eq(6)
    end
  end

  describe "#add_searchables" do
    let(:params) { { name: products[0].name}}
    it "adds id" do
      expect(query.count).to eq(1)
    end
  end
end
