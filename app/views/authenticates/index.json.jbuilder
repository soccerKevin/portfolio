json.array!(@authenticates) do |authenticate|
  json.extract! authenticate, :id, :email, :password, :password_confirmation
  json.url authenticate_url(authenticate, format: :json)
end
