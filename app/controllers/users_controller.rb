class UsersController < ApplicationController

  def index
    if !current_user
      redirect_to :action => 'login'
      flash[:notice] = "Log in alsjeblieft"
    end

  end

  def login
    if current_user
      redirect_to :action => 'index'
      flash[:notice] = "Je bent al ingelogd!"
    end

    if request.post?
      @user_check = User.find_by(username: params[:username]).try(:authenticate, params[:password])

      if @user_check
        session[:user] = @user_check
        redirect_to :action => 'index'
      else
        flash[:notice] = "We konden je niet inloggen"
      end
    end
  end

  def add

    if !current_user.nil?
      redirect_to :action => 'index'
      flash[:notice] = "Je bent al ingelogd!"
    end

    @user = User.new

    if request.post?
      @user = User.new(user_params)

      if @user.save
        redirect_to :action => 'login'

        flash[:notice] = "Succesvol geregistreerd"

      else
        flash[:notice] = "Er ging iets fout"
      end
    end
  end

  def show

  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
