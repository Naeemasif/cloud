class ApplicationController < ActionController::Base
  protect_from_forgery
  def get_user
    #@current_user = session[:current_user]
  end
  def check_admin
    if current_user == nil
      raise CanCan::AccessDenied
    else
      raise CanCan::AccessDenied unless  current_user.role == 'admin'
    end

  end
  def check_user

    raise CanCan::AccessDenied unless (current_user && (current_user.role == 'user' || current_user.role == 'admin'))
  end
  protected
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
