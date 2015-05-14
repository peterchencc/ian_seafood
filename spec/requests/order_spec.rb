require 'rails_helper'

RSpec.describe "API_V1::Orders", :type => :request do

  before do
    @product = Product.create!( :name => "Fish", :in_stock_qty => 123, :price => 100 )
    @packet = @product.packets.create!( :title => "Foo", :price => 50 )
    @product.reload
  end

  example "POST /api/v1/orders" do
    data = {
      :name => "john",
      :email => "john@gmail.com",
      :phone => "12345",
      :address => "67890",
      :line_items => [ 
        {
          :product_id => @product.id,
          :packet_id => nil,
          :qty => 1
        },
        {
          :product_id => @product.id,
          :packet_id => @packet.id,
          :qty => 2
        }
      ]
    }

    post "/api/v1/orders", data

    order = Order.last

    expect(response).to have_http_status(200)
    expect(response.body).to eq(
      {
        :message => "OK",
        :order_id => order.id,
        :pay_url => "http://www.example.com/orders/#{order.id}/checkout"
      }.to_json
    )

    expect(order.name).to eq( "john" )
    expect(order.email).to eq( "john@gmail.com" )
    expect(order.phone).to eq( "12345" )
    expect(order.address).to eq( "67890" )

    item1 = order.line_items.first
    item2 = order.line_items.last
    expect(item1.product).to eq( @product )
    expect(item1.packet).to eq( nil )
    expect(item1.qty).to eq( 1 )

    expect(item2.product).to eq( @product )
    expect(item2.packet).to eq( @packet )
    expect(item2.qty).to eq( 2 )
  end

  example "POST /api/v1/orders (failed)" do
    post "/api/v1/orders", {}

    expect(response).to have_http_status(400)
    expect(response.body).to eq(
      { "errors":
        ["Name can't be blank"]
      }.to_json
    )

    expect( Order.count ).to eq(0)
  end


end