class UsersController < ApplicationController
  def index
    @users = User.all
    @users_count = @users.count
    @users = @users.where('name ILIKE ?', "%#{params[:search]}%") if params[:search].present?
    @users = @users.page(params[:page]).per(10)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User Deleted'
  end
end
