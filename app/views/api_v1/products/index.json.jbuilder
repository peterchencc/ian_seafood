json.data do
  json.partial! "show", collection: @products, :as => :p
end

json.paging do
  json.current_page @products.current_page
  json.total_pages @products.total_pages
  json.per_page @products.limit_value
  json.next_url (@products.last_page?)? nil : v1_products_url( :page => @products.next_page )
  json.previous_url (@products.first_page?)? nil : v1_products_url( :page => @products.prev_page )
end