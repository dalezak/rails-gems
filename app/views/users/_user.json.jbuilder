json.extract! user, :id, :name, :username, :title, :description, :created_at, :updated_at
json.url user_url(user, format: :json)
