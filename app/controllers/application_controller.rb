class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in
  helper_method :has_role

  add_breadcrumb "Home", :controller => 'pages', :action => 'landing'

  def current_user
    if !session[:user].nil?
      @user = User.find(session[:user]['id'])

      @user.nil? ? Exception.new("User authenticated but record not found in database, please contact support") : @user
    else
      false
    end
  end

  def logged_in
    if session[:user].nil?
      false
    else
      true
    end
  end

  def has_role(role_id)
    if logged_in
      roles = Rolesuser.where(:user_id => current_user.id, :role_id => role_id).first

      if roles.nil?
        false
      else
        true
      end
    else
      false
    end

  end

end
