class API < Grape::API
  version 'v1'
  format :json
  prefix '/api'

  resource :feeds do
    get "/" do
      Feed.all
    end
  end
end
