class API < Grape::API
  version 'v1'
  format :json
  prefix '/api'

  resource :endpoints do
    params do
      optional :page, type: Integer, desc: "Page number"
    end
    get do
      authenticate!
      Endpoint
        .order(created_at: :desc)
        .page(params[:page])
    end

    params do
      requires :name, type: String, desc: "Endpoint name"
      requires :endpoint, type: String, desc: "Endpoint url"
    end
    post do
      authenticate!
      Endpoint.create(
        name: params[:name],
        endpoint: params[:endpoint]
      )
    end

    params do
      optional :name, type: String, desc: "Endpoint name"
      optional :endpoint, type: String, desc: "Endpoint url"
    end
    put "/:id" do
      authenticate!
      endpoint = Endpoint.find_by(id: params[:id])
      if endpoint
        endpoint.update(
          name: params[:name],
          endpoint: params[:endpoint]
        )
      end
    end

    params do
      requires :id, type: Integer, desc: "Endpoint id"
    end
    delete "/:id" do
      authenticate!
      endpoint = Endpoint.find_by(id: params[:id])
      if endpoint
        endpoint.destroy
      end
    end
  end

  resource :feeds do
    params do
      optional :page, type: Integer, desc: "Page number"
    end
    get do
      authenticate!
      Feed
        .order(entry_created: :desc)
        .page(params[:page])
    end
  end

  resource :auth do
    desc "Creates and returns access_token if valid login"
    params do
      requires :email, type: String, desc: "Email address"
      requires :password, type: String, desc: "Password"
    end
    post :login do
      user = User.find_by(email: params[:email])

      if user && user.authenticate(params[:password])
        apikey = ApiKey.find_by(user_id: user.id)
        if !apikey
          new_apikey = ApiKey.create(user_id: user.id)
          {token: new_apikey.access_token}
        else
          {token: apikey.access_token}
        end
      else
        error!("Unauthorized.", 401)
      end
    end
  end

  helpers do
    def authenticate!
      error!("Unauthorized. Invalid or expired token.", 401) unless current_user
    end

    def current_user
      token = ApiKey.where(access_token: bearer_token).first
      if token
        @current_user = User.find(token.user_id)
      else
        false
      end
    end

    def bearer_token
      authorization_header = request.headers["Authorization"]
      if !authorization_header
        return nil
      end
      authorization_header.match(/Bearer (.+)/)[1]
    end
  end
end
