require 'spec_helper'

RSpec.describe Queryko::Filters::Batch do
  let(:feature) { double('feature') }
  let(:options) do
    {
      table_name: 'products',
      column_name: 'name'
    }
  end
  let(:filter) { described_class.new(options, feature) }
  let(:names) { 'Product 2,Product 3' }

  before do
    5.times do |x|
      Product.create(name: "Product #{x}")
    end
  end


  it { expect(filter.perform(Product.all, names).count).to eq(2) }
  it { expect(filter.field).to eq('by_names') }

  # context 'when passing unsupported parameter' do
  #   let(:direction) { 'Not supported direction' }
  #   it 'defaults to ASC' do
  #     first_product = Product.all.first.id
  #     filtered = filter.perform(Product.all, names)
  #     expect(filtered.first.id).to eq(first_product)
  #   end
  # end
end
