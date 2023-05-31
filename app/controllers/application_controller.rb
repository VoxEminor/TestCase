class ApplicationController < ActionController::Base
  def authenticate_admin!
    redirect_to new_user_session_path unless current_user.admin?
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  # check_authorization
end
