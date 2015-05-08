json.id p.id
json.title p.title
json.content p.content
json.price p.price
json.video p.video
json.ingredient p.ingredient
json.pictures p.pictures do |pic|
  json.title pic.title
  json.image_original_url asset_url(pic.image.url)
  json.image_medium_url asset_url(pic.image.url(:medium))
  json.image_thumb_url asset_url(pic.image.url(:thumb))
  json.image_file_name pic.image_file_name
  json.image_content_type pic.image_content_type
  json.image_file_size pic.image_file_size
  json.image_updated_at pic.image_updated_at
end
