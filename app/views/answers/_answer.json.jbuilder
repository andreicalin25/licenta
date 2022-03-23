json.extract! answer, :id, :text, :votes, :created_at, :updated_at
json.url answer_url(answer, format: :json)
