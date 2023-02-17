class HomesController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show_user
    @user = User.find(params[:id])
  end

end
