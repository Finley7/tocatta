class UsersController < ApplicationController

  def index
    if !logged_in
      redirect_to :action => 'login'
      flash[:notice] = "Log in alsjeblieft"
    end

  end

  def login
    if logged_in
      message('alert', 'Je bent al ingelogd')
      redirect_to :action => 'index'
    end

    if request.post?
      @user_check = User.find_by(username: params[:username]).try(:authenticate, params[:password])

      if @user_check
        session[:user] = @user_check

        message('success', "Welkom terug, " + @user_check.username)

        redirect_to :action => 'index'
      else

        message('alert', 'We konden je niet inloggen')

      end
    end
  end

  def add

    if logged_in

      message('alert', 'Je bent al ingelogd')

      redirect_to :action => 'index'
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

          message('success', 'Je account is aangemaakt en je kunt nu inloggen!')
        end
        message('alert', 'Er ging iets fout!')

      else
        message('alert', 'Er ging iets fout')
      end

    end
  end

  def logout

    if request.post?
      if logged_in

        session.destroy

        message('success', 'Je bent uitgelogd')

        redirect_to :action => 'login'

      end
    end

  end

  def edit
    if !logged_in
      message('alert', 'Je bent al ingelogd')

      redirect_to :action => 'index'
    end

    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
