class SessionsController < ApplicationController
  skip_before_action :check_signed_in, only: :create

  def create
    if (user = User.find_or_create_from_auth_hash(auth_hash))
      sign_in user
    end
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
