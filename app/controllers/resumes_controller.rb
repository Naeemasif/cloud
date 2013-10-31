class ResumesController < ApplicationController
           before_filter :authenticate_user!
  def index
       @user = current_user

      @resumes = @user.resumes.all

  end

  def new
    @resume = Resume.new
  end

  def create
    #render :text => params[:resume].inspect
     @user = current_user
    @resume = Resume.new(params[:resume])
      @resume.user_id = @user.id
    if @resume.save
      a=current_user.space-(current_user.resumes.last.file_size/(1024*1024))
      current_user.update_attributes(:space => a)
      redirect_to resumes_path, notice: "The resume #{@resume.name} has been uploaded."
    else
      render "new"
    end
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to resumes_path, notice:  "The resume #{@resume.name} has been deleted."
  end


end
