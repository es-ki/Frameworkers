class SessionsController < ApplicationController
  skip_before_action :check_signed_in, only: :create

  def create
    user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    sign_in(user)
    redirect_referrer notice: "サインインしました。"
  rescue ActiveRecord::RecordNotSaved
    redirect_referrer alert: "ユーザーの保存に失敗しました。"
  rescue StandardError
    redirect_referrer alert: "予期せぬエラーが発生しました。"
  end

  def failure
    redirect_referrer alert: "サインインに失敗しました。"
  end

  def destroy
    sign_out
    redirect_to root_path, notice: "サインアウトしました。"
  end

  private

  def redirect_referrer(flash_message = {})
    redirect_to "#{session.delete(:return_to)}#analysis" || root_path, flash_message
  end
end
