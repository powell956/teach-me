json.extract! user, :id, :username, :password_digest, :name, :bio, :created_at, :updated_at
json.url user_url(user, format: :json)
