class AuthController < ApplicationController
  protect_from_forgery except: :authenticate_user
  before_action :authenticate_request!, only: [:get_auth]
  require 'jwt'

  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def get_auth
    render json: @current_user
  end

  private
  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JWT.encode({user_id: user.id, exp: (Time.now + 2.week).to_i}, nil, 'none'),
      user: {id: user.id, email: user.email}
    }
  end
end
