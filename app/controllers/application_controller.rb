class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  load_and_authorize_resource unless: -> { devise_controller? || controller_name == 'admin_bills' }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
end
