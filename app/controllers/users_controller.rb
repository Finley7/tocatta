class UsersController < ApplicationController

  def index
    if !logged_in
      redirect_to :action => 'login'
      flash[:notice] = "Log in alsjeblieft"
    end

  end

  def login
    if logged_in
      redirect_to :action => 'index'

      flash[:message] = "Je bent al ingelogd!"
      flash[:type] = "alert"

    end

    if request.post?
      @user_check = User.find_by(username: params[:username]).try(:authenticate, params[:password])

      if @user_check
        session[:user] = @user_check

        flash[:message] = "Welkom terug, " + @user_check.username
        flash[:type] = "success"

        redirect_to :action => 'index'
      else

        flash[:message] = "We konden je niet inloggen"
        flash[:type] = "alert"

      end
    end
  end

  def add

    if logged_in
      redirect_to :action => 'index'

      flash[:message] = "Je bent al ingelogd!"
      flash[:type] = "alert"

    end

    @user = User.new

    if request.post?
      @user = User.new(user_params)

      @user.primary_role = 1

      if @user.save
        roleuser = Rolesuser.new
        roleuser.user_id = @user.id
        roleuser.role_id = 1

        if roleuser.save
          redirect_to :action => 'login'

          flash[:message] = "Je kunt nu inloggen!"
          flash[:type] = "success"
        end
        flash[:message] = "Er ging iets fout"
        flash[:type] = "alert"

      else
        flash[:message] = "Er ging iets fout"
        flash[:type] = "alert"
      end

    end
  end

  def logout

    if request.post?
      if logged_in

        session.destroy

        redirect_to :action => 'login'

        flash[:message] = "Je bent uitgelogd!"
        flash[:type] = "success"

      end
    end

  end

  def edit
    if !logged_in
      redirect_to :action => 'index'

      flash[:message] = "Log in alsjeblieft"
      flash[:type] = "alert"
    end

    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
