require 'dropbox_sdk'
class ResumesController < ApplicationController
  before_filter   :authenticate_user!
  APP_KEY = 'x48vnwl4fgnelmx'
  APP_SECRET = 's2ixzu5cfr6wydi'

  @@flow = DropboxOAuth2FlowNoRedirect.new(APP_KEY, APP_SECRET)
  def index

        @user = current_user
        @resumes = @user.resumes.all
         #Get your app key and secret from the Dropbox developer website


        @authorize_url = @@flow.start()

# Have the user sign in and authorize this app
    #puts '1. Go to: ' + @authorize_url
    #puts '2. Click "Allow" (you might have to log in first)'
    #puts '3. Copy the authorization code'
    #print 'Enter the authorization code here: '
    #code = gets.strip

# This will fail if the user gave us an invalid authorization code
   # access_token, user_id = flow.finish('TqtgYyGj79UAAAAAAAAAAUueKTTWKdH0bOY1SuLVIZQ')

    #client = DropboxClient.new(access_token)
    #puts "linked account:", client.account_info().inspect

    #file = open('temp.txt')
    #response = client.put_file('/Files', file)
    #puts "uploaded:", response.inspect

    #root_metadata = client.metadata('/')
    #puts "metadata:", root_metadata.inspect

    #contents, metadata = client.get_file_and_metadata('/magnum-opus.txt')
    #open('magnum-opus.txt', 'w') {|f| f.puts contents }

  end

  def new
    @resume = Resume.new
  end

  def create
     @code = params[:code]
     @resume =Resume.new(params[:resume])

     access_token, user_id = @@flow.finish(@code)
     client = DropboxClient.new(access_token)
    puts "linked account:", client.account_info().inspect


     @user = current_user
     @resume.user_id = @user.id
    if @resume.save!
      file = open("#{Rails.root}/public#{@resume.attachment_url}")
      response = client.put_file("#{@resume.name}", file )
      puts "uploaded:", response.inspect
       @resume.destroy

      @root_metadata = client.metadata('/')


       #@root_metadata.each  do |key , val|
        # puts key
        # puts "****************************************************************************************"
        # puts val

      # end

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
  def start

  end




end
