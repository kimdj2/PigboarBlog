class Users::SessionsController < Devise::SessionsController
    def create
        resource = User.find_for_database_authentication(email: params[:user][:email])
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:user][:password])
            self.resource = warden.authenticate!(auth_options)
            sign_in(resource_name, resource)
            yield resource if block_given?
            respond_with resource, location: after_sign_in_path_for(resource)
        else
            invalid_login_attempt
        end
    end

    protected

    def invalid_login_attempt
        set_flash_message(:alert, :invalid)
        render json: flash[:alert], status: 401
    end
end