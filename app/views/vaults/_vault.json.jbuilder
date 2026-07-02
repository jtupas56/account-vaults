json.extract! vault, :id, :site, :url, :login, :password, :created_at, :updated_at
json.url vault_url(vault, format: :json)
