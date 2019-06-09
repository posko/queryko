require 'spec_helper'

RSpec.describe Queryko::Filters::Order do
  let(:feature) { double('feature') }
  let(:options) do
    {
      table_name: 'products',
      column_name: 'id'
    }
  end
  let(:filter) { described_class.new(options, feature) }
  let(:direction) { 'DESC' }

  before do
    5.times do |x|
      Product.create(name: "Product #{x}")
    end
  end


  it { expect(filter.perform(Product.all, direction).first.id).to eq(Product.all.last.id) }
  it { expect(filter.field).to eq('order_by_id') }

  context 'when passing unsupported parameter' do
    let(:direction) { 'Not supported direction' }
    it 'defaults to ASC' do
      first_product = Product.all.first.id
      filtered = filter.perform(Product.all, direction)
      expect(filtered.first.id).to eq(first_product)
    end
  end
end
