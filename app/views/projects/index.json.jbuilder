json.array!(@projects) do |project|
  json.extract! project, :id, :name, :technologies_used
  json.url project_url(project, format: :json)
end
