class ResumesController < ApplicationController
  require 'rubygems' # not necessary with ruby 1.9 but included for completeness
  require 'twilio-ruby'
  def index
    if user_signed_in?
       @user = current_user
       @resumes = @user.resumes.all
      end

  end

  def new
    @resume = Resume.new
  end

  def create
    #render :text => params[:resume].inspect
     @user = current_user
     @resume = Resume.new(params[:resume])
     @resume.user_id = @user.id
    #  if current_user.space.to_i == 0
     #   flash[:file_status] = "File Cannot be Uploaded"
      #  redirect_to :action =>"index"
      #end
      #if (current_user.resumes.last.file_size/(1024*1024)) .to_i > current_user.space.to_i
       # flash[:file_status] = "File Cannot be Uploaded size greater than expected"
        #redirect_to :action =>"index"
      #end

    if @resume.save
      a=current_user.space.to_i - (current_user.resumes.last.file_size/(1024*1024)).to_i
      b=(current_user.resumes.last.file_size/(1024*1024)).to_i + current_user.allocated_space.to_i
      current_user.update_attributes(:space => a.to_i.to_s,:allocated_space=>b.to_i.to_s)
      redirect_to resumes_path, notice: "The resume #{@resume.name} has been uploaded."
    else
      render "new"
    end
  end

  def destroy
    @resume = Resume.find(params[:id])
    a = current_user.space + (@resume.file_size/(1024*1024))
    b = current_user.allocated_space.to_i - (@resume.file_size/(1024*1024)).to_i
    if @resume.destroy

    current_user.update_attributes(:space => a,:allocated_space=>b)
    redirect_to resumes_path, notice:  "The resume #{@resume.name} has been deleted."
    end

  end

  def sms
    require 'rubygems'
    require 'twilio-ruby'

    @account_sid = 'ACf3050b4f953a67f825892b24d9b0dc6b'
    @auth_token = '2d78cda3016a0dae82e91172fadc4312'

                  # set up a client to talk to the Twilio REST API
        @client = Twilio::REST::Client.new(@account_sid, @auth_token)


    @account = @client.account
    @message = @account.sms.messages.create({:from => '+12243658349', :to => '+923456565187', :body => 'Hi Admin
 I\'m out of space allocate me some more space. '})
    puts @message
  end

end
