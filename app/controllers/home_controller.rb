class HomeController < ApplicationController
  skip_before_action :check_signed_in, only: :index

  def index
  end
end
