# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # Override the method to customize the redirect after sign in
  def after_sign_in_path_for(resource)
    if resource.has_role?(:admin)
      employees_path # Redirect to employees index for admin users
    elsif resource.has_role?(:employee)
      bills_path # Redirect to bills index for employee users
    else
      super # Default behavior (fallback)
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
