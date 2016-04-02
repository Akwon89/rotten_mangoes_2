class Admin::UsersController < Admin::AdminController

  # before_action :admin_only

  def index
    @users = User.all.page(params[:page]).per(2)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
        redirect_to admin_users_path, notice: "Admin added user, #{@user.full_name}"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      if params[:user][:admin] == "1"
        @user.update_column(:admin,true)
        ##makes admin if checked####
      end
      redirect_to admin_users_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.delete_email(@user).deliver_now

    # format.html { redirect_to(@user, notice: 'User was succesfully deleted') }
    # format.json { render json: @user, status: :deleted, location: @user }
    redirect_to admin_users_path

    return
  end


  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
 
end