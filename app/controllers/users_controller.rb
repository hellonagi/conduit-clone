class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome to Conduit Clone!'
      redirect_to profile_url(@user.username)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
