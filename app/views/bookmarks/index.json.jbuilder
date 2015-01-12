json.array!(@bookmarks) do |bookmark|
  json.extract! bookmark, :id, :name, :url, :topics, :user_id
  json.url bookmark_url(bookmark, format: :json)
end
