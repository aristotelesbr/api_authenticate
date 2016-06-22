class Api::V1::AuthController < ApplicationController
  before_action :authenticate!, only: [:index ]
	def index
    @api_v1_posts = Post.all
    render json: @api_v1_posts
  end

  def show
    
  end

  def auth
    if params[:auth][:email].include?("@")
      if @user = User.find_by_email(params[:auth][:email].downcase) 
        key = ApiKey.create(user_id: @user.id)
        @user.api_key = {token: key.access_token}
        binding.pry
        response.headers["X-AUTH-TOKEN"] = key.access_token
        render json: @user
      else
        @user = User.find_by_name(params[:auth][:name].downcase) 
      end

      # binding.pry
      # if @user && @user.authenticate(params[:auth][:password])
      #   render json: @user
      #   key = ApiKey.create(user_id: @user.id)
      #   {token: key.access_token}
      # else
      #   render json: { error: 'Não autorizado' }, status: 400
      # end
    end
  end

  private

  def authenticate!
      binding.pry
    render json: { error: 'Não autorizado' }, status: 400 unless current_user
  end

  def current_user
    response.headers["X-AUTH-TOKEN"]
    # find token. Check if valid.
    token = ApiKey.where(access_token: headers["X-AUTH-TOKEN"])
      binding.pry
      if token.first && !token.first.expired?
        @current_user = User.find(token.first.user_id)
      else
        false
      end
  end
end