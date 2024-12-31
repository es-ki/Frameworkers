class SessionsController < ApplicationController
  skip_before_action :check_signed_in, only: :create

  def create
    auth = auth_hash

    user = User.find_or_create_from_auth_hash(auth)
    sign_in(user)

    redirect_to root_path, notice: "Googleアカウントでログインしました。"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to root_path, alert: "ログインに失敗しました: #{e.record.errors.full_messages.to_sentence}"
  end

  def failure
    redirect_to root_path, alert: "ログインに失敗しました。"
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
