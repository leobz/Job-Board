json.extract! company, :id, :name, :email, :password, :phone, :image_url, :website, :created_at, :updated_at
json.url company_url(company, format: :json)
