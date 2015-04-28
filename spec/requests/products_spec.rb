require 'rails_helper'

RSpec.describe "API_V1::Products", :type => :request do

  let!(:p1) { Product.create!( :name => "A", :price => 100 ) }
  let!(:p2) { Product.create!( :name => "B", :price => 200 ) }

  example "GET /api/v1/products" do

    get "/api/v1/products"

    expect(response).to have_http_status(200)

    expect(response.body).to eq(
      {
        data: [
          {
            url: "http://www.example.com/api/v1/products/#{p1.id}",
            id: p1.id,
            name: p1.name,
            price: p1.price,
            description: p1.description,
            created_at: p1.created_at,
            updated_at: p1.updated_at
          },
          {
            url: "http://www.example.com/api/v1/products/#{p2.id}",
            id: p2.id,
            name: p2.name,
            price: p2.price,
            description: p2.description,
            created_at: p2.created_at,
            updated_at: p2.updated_at
          }
        ],
        paging: {
          current_page: 1,
          total_pages: 1,
          per_page: 25,
          next_url: nil,
          previous_url: nil
        }
      }.to_json
    )
  end

end