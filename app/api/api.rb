class API < Grape::API
  version 'v1'
  format :json
  prefix '/api'

  resource :feeds do

    params do
      optional :page, type: Integer, desc: "Page number"
    end

    get "/" do
      Feed
        .order(entry_created: :desc)
        .page(params[:page])
    end
  end
end
