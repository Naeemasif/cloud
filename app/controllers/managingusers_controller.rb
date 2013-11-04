class ManagingusersController < ApplicationController
  def index
    @users =  User.all
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      redirect_to managingusers_path
    end

  end
end
