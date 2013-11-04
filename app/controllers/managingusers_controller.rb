class ManagingusersController < ApplicationController
  before_filter :check_admin
  require 'sys/filesystem'

  def index
    @users =  User.all
    stat = Sys::Filesystem.stat('/')
    @mb_available = stat.block_size * stat.blocks_available / 1024 / 1024
    @mb_total = stat.block_size * stat.blocks/ 1024 / 1024
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

  def getspace
    stat = Sys::Filesystem.stat('/')
    @mb_available = stat.block_size * stat.blocks_available / 1024 / 1024
  end
end
