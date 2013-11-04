class ManagingusersController < ApplicationController
  def index
    @users =  User.all
  end

  def new
  end

  def create
  end

  def update
    @user = User.find(params[:id])

  end

  def update_allocated_user_space
    @user = User.find(params[:ID])
    @user.update_attributes(space:params[:space])
    flash[:notice] = "Space allocated Successully"
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      redirect_to managingusers_path
    end

  end
end
