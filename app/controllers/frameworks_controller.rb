class FrameworksController < ApplicationController
  skip_before_action :check_signed_in, only: :show

  def show
    @framework = Cms.fetch_framework(params[:id])
    return unless current_user.present?

    @projects = current_user.projects.map do |project|
      {
        public_id: project[:public_id],
        name: project[:name]
     }
    end.compact

    if params[:pid].present?
      project = current_user.projects.find_by(public_id: params[:pid])
      @analysis = project.send("#{params[:id]}s").order(created_at: :desc).first if project
    else
      project = current_user.projects.first
      @analysis = project.send("#{params[:id]}s").order(created_at: :desc).first if project
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
