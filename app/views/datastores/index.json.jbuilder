json.array!(@datastores) do |datastore|
  json.extract! datastore, :id, :type, :version, :url, :user_id, :project_id
  json.url datastore_url(datastore, format: :json)
end
