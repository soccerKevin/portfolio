json.array!(@blog_entries) do |blog_entry|
  json.extract! blog_entry, :id, :name, :title, :content
  json.url blog_entry_url(blog_entry, format: :json)
end
