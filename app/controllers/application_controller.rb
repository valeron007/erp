class ApplicationController < ActionController::Base

  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_filter :set_paper_trail_whodunnit, :set_session_per_page

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == "new"
      "login"
    else
      "application"
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:error] = t('Access Denied');
    redirect_to(request.referrer || dashboard_path)
  end

  def user_for_paper_trail
    # Save the user responsible for the action
    user_signed_in? ? current_user.id : 'Guest'
  end

  def redirect_back_or_default(default, message)
    redirect_to get_return_to_or_default(default), notice: message
    session[:return_to] = nil
  end

  def set_return_to
    session[:return_to] = request.env["HTTP_REFERER"]
  end

  def get_return_to_or_default(default)
    session[:return_to] || default
  end

  def set_session_per_page
    session[:session_per_page] = params[:per_page].to_i unless params[:per_page].nil?
  end

  def get_session_per_page(default)
    session[:session_per_page] || default
  end

end
