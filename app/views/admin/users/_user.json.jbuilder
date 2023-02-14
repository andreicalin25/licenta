json.extract! user, :id, :email, :last_name, :first_name, :phone, :role, :activated, :group, :created_at, :updated_at
json.url user_url(user, format: :json)
