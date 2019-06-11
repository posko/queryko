require 'spec_helper'

RSpec.describe Queryko::Filters::Search do
  let(:feature) { double('feature') }
  let(:options) do
    {
      table_name: 'products',
      column_name: 'name',
      cond: cond
    }
  end
  let(:filter) { described_class.new(options, feature) }
  let(:token) { 'Product' }
  let(:cond) { :like }
  before do
    5.times do |x|
      Product.create(name: "Product #{x}")
    end
  end
  it { expect(filter.cond).to eq(:like) }
  it { expect(filter.perform(Product.all, token, nil).count).to eq(5) }

  describe 'eq' do
    let(:token) { 'Product 1' }
    let(:cond) { :eq }

    it { expect(filter.perform(Product.all, token, nil).count).to eq(1) }
  end

  describe 'not' do
    let(:token) { 'Product 1' }
    let(:cond) { :neq }

    it { expect(filter.perform(Product.all, token, nil).count).to eq(4) }
  end
end
