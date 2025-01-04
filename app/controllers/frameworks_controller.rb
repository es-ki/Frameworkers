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
      @analysis = get_analysis(project, params[:id]) if project
    else
      project = current_user.projects.first
      @analysis = get_analysis(project, params[:id]) if project
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private

  def get_analysis(project, framework_id)
    case framework_id
    when "swot"
      project.swots.order(created_at: :desc).first
    else
      nil
    end
  end
end
