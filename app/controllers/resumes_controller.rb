require 'dropbox_sdk'
class ResumesController < ApplicationController
  before_filter   :authenticate_user!
  def index

        @user = current_user
        @resumes = @user.resumes.all

  end

  def connect


    session[:code] = params[:code].to_s
    session[:access_token], session[:user_id] = session[:flow].finish(session[:code])
    session[:client] = DropboxClient.new(session[:access_token])
    puts "linked account:", session[:client].account_info().inspect
  end

  def new
    @resume = Resume.new
  end

  def create

      @resume =Resume.new(params[:resume])


      #access_token = session[:access_token]


      @user = current_user
     @resume.user_id = @user.id
    if @resume.save!
      file = open("#{Rails.root}/public#{@resume.attachment_url}")
      response = session[:client].put_file("#{@resume.name}", file )
      puts "uploaded:", response.inspect
       @resume.destroy



     # contents, metadata = client.get_file_and_metadata("#{@resume.name}")
     # open("#{@resume.name}", 'w') {|f| f.puts contents }



    else
      render "new"
    end

end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to resumes_path, notice:  "The resume #{@resume.name} has been deleted."
  end

  def reg

    session[:APP_KEY] = 'x48vnwl4fgnelmx'
    session[:APP_SECRET] = 's2ixzu5cfr6wydi'
    session[:flow] = DropboxOAuth2FlowNoRedirect.new(session[:APP_KEY], session[:APP_SECRET])
    @authorize_url = session[:flow].start()

  end

  def show
    @root_metadata = session[:client].metadata('/')

  end




end
