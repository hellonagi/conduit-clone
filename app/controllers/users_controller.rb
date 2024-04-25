class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update]

  def show
    @user = User.find_by(username: params[:username])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = 'Welcome to Conduit Clone!'
      redirect_to profile_url(@user.username)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_edit_params)
      flash[:success] = 'Profile updated'
      redirect_to profile_url(@user.username)
    else
      @user.reload
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def user_edit_params
    params.require(:user).permit(:username, :email, :image, :bio, :password)
  end

  # beforeフィルタ

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url, status: :see_other
  end
end
