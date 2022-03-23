json.extract! subject, :id, :subject_name, :type, :created_at, :updated_at
json.url subject_url(subject, format: :json)
