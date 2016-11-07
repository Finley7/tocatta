class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    if !session[:user].nil?
      @user = User.find(session[:user]['id'])

      @user.nil? ? Exception.new("User authenticated but record not found in database, please contact support") : @user
    else
      false
    end
  end
end
