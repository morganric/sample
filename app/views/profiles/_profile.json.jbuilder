json.extract! profile, :id, :user_id, :bio, :image, :slug, :display_name, :twitter, :created_at, :updated_at
json.url profile_url(profile, format: :json)