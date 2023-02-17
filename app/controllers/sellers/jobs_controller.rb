class Sellers::JobsController < ApplicationController

  before_action :authenticate_user!

  layout 'application'

  before_action :get_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = Job.where(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.json {
        render json: JobsDatatable.new(view_context, { recordset: @jobs }) }
    end
  end

  def search
    if params[:search].blank?
      redirect_to sellers_jobs_path
    else
      @parameter = params[:search].downcase
      @results = current_user.jobs.where("lower(task_title) LIKE  :search", search: "%#{@parameter}%")
    end
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params.merge(user_id: current_user.id))
    # @job = Job.new(users_jobs_id)
    if @job.save
      redirect_to sellers_jobs_path, notice: 'Job created successfully.'
    else
      puts "===========#{@job.errors.full_messages}"
      render 'new'
    end
  end

  def edit
    puts "===========#{@job.inspect}"
  end

  def update
    puts "===========#{job_params.inspect}"
    if @job.update(job_params)
      redirect_to sellers_jobs_path, notice: 'Job updated successfully.'
    else
      render 'edit'
    end
  end

  def destroy
    @job.destroy
    redirect_to sellers_jobs_path, notice: 'Job deleted successfully.'
  end

  private

  def job_params
    params.require(:job).permit(:task_title, :category_id, :payment_type, :subscription_name, :price, :description, :job_description, :instrument, :influences, :equipment, :experience, :instruction_to_buyer, :availability, :from_availability_time, :to_availability_time, :location, :video_link, :tags, :image, images: [])
  end

  def get_job
    @job = Job.find(params[:id])
  end

end

