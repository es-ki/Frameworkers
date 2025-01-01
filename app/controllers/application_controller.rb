class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include SessionsHelper
  before_action :check_signed_in

  def check_signed_in
    return if current_user
    redirect_to root_path
  end
end
