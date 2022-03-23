json.extract! question, :id, :title, :details, :importance, :votes, :created_at, :updated_at
json.url question_url(question, format: :json)
