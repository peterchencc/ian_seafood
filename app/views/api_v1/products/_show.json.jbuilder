json.id p.id
json.name p.name
json.price p.price
json.description p.description
json.rating p.rating
json.created_at p.created_at
json.updated_at p.updated_at
json.in_stock_qty p.in_stock_qty

json.image_original_url asset_url(p.image.url)
json.image_medium_url asset_url(p.image.url(:medium))
json.image_thumb_url asset_url(p.image.url(:thumb))
json.image_file_name p.image_file_name
json.image_content_type p.image_content_type
json.image_file_size p.image_file_size
json.image_updated_at p.image_updated_at

json.packets do
  json.partial! "packet", collection: p.packets, :as => :p
end