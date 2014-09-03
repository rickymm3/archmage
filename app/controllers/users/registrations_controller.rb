module Users
  include CreateUserHelper
  class RegistrationsController < Devise::RegistrationsController
    # before_filter :configure_permitted_parameters, if: :devise_controller?
    def create
      super
      if @user.persisted?
        create_new_user(@user)
      end

    end

    private

    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.for(:sign_up) {|u|
    #     u.permit(:email, :password, :password_confirmation, profile_attributes: [:username])}
    # end

  end
end