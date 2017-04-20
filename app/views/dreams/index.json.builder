json.array!(@dreams) do |dream|
  json.extract! drea,, :id, :dream, :achieved
  json.url task_url(dream, format: :json)
end