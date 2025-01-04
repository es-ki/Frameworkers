class SwotsController < ApplicationController
  def create
    public_id = params[:swot][:public_id]
    project = current_user.projects.find_by(public_id: public_id)
    swot = project.swots.new(swot_params)
    swot.save!
    redirect_to swot_path(pid: public_id, anchor: "analysis"), notice: "SWOT分析を保存しました。"
  rescue ActiveRecord::RecordNotSaved => e
    ErrorUtility.logger(e, "SWOT分析保存")
    redirect_to swot_path, alert: "SWOT分析の保存に失敗しました。"
  rescue StandardError => e
    ErrorUtility.logger(e)
    redirect_to swot_path, alert: "予期せぬエラーが発生しました。"
  end

  private

  def swot_params
    params.require(:swot).permit(:strength, :weakness, :opportunity, :threat, :analysis, :project_id)
  end
end
