class Buyers::HomesController < ApplicationController

  def index
    @pagy, @jobs = pagy(Job.all)
  end


  def show
    @job = Job.find(params[:id])
  end

  def search
    if params[:search].blank?
      redirect_to buyers_homes_path
    else
      @parameter = params[:search].downcase
      @results = Job.where("lower(task_title) LIKE  :search", search: "%#{@parameter}%")
    end
  end

end
