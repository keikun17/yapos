class UsersController < ApplicationController


  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  # def update
  #   @user = User.find(params[:id])
  #   @user.update_attributes(params[:user])
  #   redirect_to users_path
  # end

end
