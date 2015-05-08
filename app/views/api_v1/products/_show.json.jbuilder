json.url v1_product_url(@i)
json.id "#{@i}"
json.name "魚 NO. #{@i}"
json.price "價格 #{@i}"
json.description "便宜又新鮮#{@i}"
json.created_at "2015/05/06"
json.updated_at "2015/05/07"
json.in_stock_qty "目前有 #{@1i}個"
json.photo "http://robohash.org/sitsequiquia.png?size=300x300"
json.rating "4"

# json.image_original_url asset_url(p.image.url)
# json.image_medium_url asset_url(p.image.url(:medium))
# json.image_thumb_url asset_url(p.image.url(:thumb))
# json.image_file_name p.image_file_name
# json.image_content_type p.image_content_type
# json.image_file_size p.image_file_size
# json.image_updated_at p.image_updated_at