namespace :dev do
  desc "Generate fake data"

  task fakeup: ['db:schema:load', :environment] do
    User.create( :email => "ihower@gmail.com", :password => "12345678", :role => "admin")

    20.times do |i|
    Product.create!(
                  name: "seafood no.#{i}", 
                  description: "description seafood no.#{i}",
                  price: (rand(10) + 1) * 50,
                  image_url: Faker::Avatar.image, 
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
          price: (rand(10) + 1) * 20,
          video: Faker::Internet.url
        )
      end
    end

    Packet.all.sample(5).each do |p|
      cart.line_items.create!( packet: p, subtotal: p.final_price, qty: rand(4) + 1 )
    end    
  end  
end
