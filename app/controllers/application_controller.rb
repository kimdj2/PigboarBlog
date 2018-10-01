class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :setContact
  after_action  :store_location

  rescue_from ActionController::RoutingError, with: :handle_404 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound,   with: :handle_404 unless Rails.env.development?

  def store_location
    if (request.fullpath != new_user_registration_path &&
        request.fullpath != new_user_session_path &&
        request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
        !request.xhr?)
      session[:previous_url] = request.fullpath 
    end
  end
 
  def after_sign_in_path_for(resource)
    if (session[:previous_url] == root_path)
      super
    else
      session[:previous_url] || root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end 
   
  protected

  def configure_permitted_parameters
    added_attrs = [:email, :username, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def setTagAndCategory
    @tags = ActsAsTaggableOn::Tag.where("taggings_count <> 0").order(name: "ASC")
    @board_month = Board.select("date_trunc( 'month', created_at ) as month, count(*) as total_month").group('month')
  end 
  
  def setContact
    @contact = Contact.new
  end 
  
end
