class SessionsController < ApplicationController
  skip_before_action :check_signed_in, only: :create

  def create
    user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    sign_in(user)
    redirect_to root_path, notice: "サインインしました。"
  rescue ActiveRecord::RecordNotSaved
    redirect_to root_path, alert: "ユーザーの保存に失敗しました。"
  rescue StandardError
    redirect_to root_path, alert: "予期せぬエラーが発生しました。"
  end

  def failure
    redirect_to root_path, alert: "サインインに失敗しました。"
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
