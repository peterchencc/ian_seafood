require 'rails_helper'

RSpec.describe Cart, type: :model do

  before do
    @cart = Cart.create
    @product = Product.create!(:name => "Foo", :price => 100)
  end

  describe "#add_line_item" do
    it "it should add new product to line_items" do
      new_line_item = @cart.add_line_item(@product)
      new_line_item.save

      expect(@cart.line_items.count).to eq(1)

      line_item = @cart.line_items.last
      expect(line_item.product).to eq(@product)
      expect(line_item.qty).to eq(1)
    end

    it "it should add new product to line_items" do
      new_line_item1 = @cart.add_line_item(@product)
      new_line_item1.save

      new_line_item2 = @cart.add_line_item(@product)
      new_line_item2.save

      expect(@cart.line_items.count).to eq(1)

      line_item = @cart.line_items.last
      expect(line_item.product).to eq(@product)
      expect(line_item.qty).to eq(2)
    end
  end

  describe "#total" do
    xit "it should sum line_items amount"
  end
end
