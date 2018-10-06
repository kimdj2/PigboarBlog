module ControllerMacros
    def login_user
        before(:each) do
            controller.stub(:authenticate).and_return true
            @request.env["devise.mapping"] = Devise.mappings[:user]
            sign_in create(:user)
        end
    end
end