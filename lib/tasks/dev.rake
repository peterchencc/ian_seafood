namespace :dev do

  task :fake => :environment do
    Product.delete_all
    User.delete_all

    User.create( :email => "ihower@gmail.com", :password => "12345678", :role => "admin")

    50.times do
      Product.create!( :name => Faker::App.name,
                       :price => ( rand(50)+1 ) * 10 ,
                       :image_url => Faker::Avatar.image,
                       :description => Faker::Lorem.paragraph,
                       :in_stock_qty => rand(10) )
    end
  end

end