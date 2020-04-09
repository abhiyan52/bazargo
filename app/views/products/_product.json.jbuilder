json.extract! product, :id, :url, :title, :description, :price, :image_url, :mobile_number, :user_id, :refreshed_at, :created_at, :updated_at
json.url product_url(product, format: :json)
