class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include BlogCommon
 
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

end
