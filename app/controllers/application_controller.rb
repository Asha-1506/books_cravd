class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :authenticate_user!
  before_action :clear_devise_flash_messages
  
  private
  
  def clear_devise_flash_messages
    flash.clear if flash[:notice] == "Signed in successfully."
  end
end
