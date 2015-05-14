namespace :dev do
  desc "Generate fake data"

  task fakeup: ['db:drop', 'db:create', 'db:schema:load', :environment] do
    User.create( :email => "ihower@gmail.com", :password => "12345678", :role => "admin")

    20.times do |i|
    Product.create!(
                  name: "seafood no.#{i}", 
                  description: "description seafood no.#{i}",
                  price: (rand(10) + 1) * 50,
                  image: Faker::Avatar.image, 
                  in_stock_qty: rand(10) 
                  )
    end

    cart = Cart.create!

    # build會產生關聯
    Product.all.each do |p|
      5.times do |i|
        p.packets.create!( 
          title: "packet no.#{i}", 
          content: Faker::Lorem.paragraph,
          ingredient: Faker::Lorem.paragraph, 
          price: (rand(10) + 1) * 20,
          video: Faker::Internet.url
        )
      end
    end

    Packet.all.sample(4).each do |p|
      cart.line_items.create!( product: Product.all.sample, packet: p, subtotal: p.final_price, qty: rand(4) + 1 )
    end 

    paid_order = Order.create name: 'Tony', address: '樹林', payment_method: 'Credit', phone: '0933111222',
                 email: 'example@gmail.com'
    paid_order.line_items.create! product: Product.all.sample, subtotal: 123, qty: 1
    paid_order.trades.create! paid: true
    unpaid_order = Order.create! name: 'Jason', address: '板橋', payment_method: 'ATM', phone: '0900111222',
                 email: 'example2@gmail.com'
    unpaid_order.line_items.create product: Product.all.sample, subtotal: 123, qty: 1
    unpaid_order.trades.create! paid: false   
  end  
end
