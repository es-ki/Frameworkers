class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :store_referrer_in_session, :check_signed_in

  include SessionsHelper

  def check_signed_in
    return if current_user
    redirect_to root_path
  end

  private

  def store_referrer_in_session
    if request.get? && internal_url?(request.referer)
      session[:return_to] = request.fullpath
    end
  end

  def internal_url?(url)
    return false if url.nil?

    app_url = URI.parse(root_url)
    uri = URI.parse(url)
    uri.host == app_url.host
  rescue URI::InvalidURIError
    false
  end
end
