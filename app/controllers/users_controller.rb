class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|

      if @user.save
        session[:user_id] = @user.id #auto log in
        UserMailer.welcome_email(@user).deliver_now

        format.html { redirect_to(@user, notice: 'User was succesfully created') }
        format.json { render json: @user, status: :created, location: @user }
        redirect_to movies_path, notice: "welcome aboard, #{@user.firstname}"
        return
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entry}
        render :new
      
      end
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end
