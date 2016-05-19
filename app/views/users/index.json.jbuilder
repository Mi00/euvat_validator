json.array!(@users) do |user|
  json.extract! user, :id, :name, :surname, :euvat
  json.url user_url(user, format: :json)
end
