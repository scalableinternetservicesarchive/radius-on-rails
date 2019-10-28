json.extract! user, :id, :name, :bio, :lat, :lng, :created_at, :updated_at
json.url user_url(user, format: :json)
