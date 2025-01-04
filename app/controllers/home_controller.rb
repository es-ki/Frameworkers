class HomeController < ApplicationController
  skip_before_action :check_signed_in, only: :index

  def index
    @frameworks = Cms.fetch_frameworks "limit=3"
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
