class ApplicationController < ActionController::Base
  ##protect_from_forgery with: :exception
  include BlogCommon
  attr_reader :current_user
  require 'jwt'

  protected

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token['user_id'])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JWT.decode(http_token, nil, false)[0]
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

end
