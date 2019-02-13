class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = Job.new

  end

  def edit
  end

  def create

    @job = Job.new(job_params(:description, :location, :time, :rate, :topic_id))

    if params[:job][:type_of_user] == "Student"
      @job.student_id = current_user.id
    elsif params[:job][:type_of_user] == "Tutor"
      @job.tutor_id = current_user.id
    end

    # respond_to do |format|
      if @job.save

        redirect_to '/job_board'
        # format.html { redirect_to @job, notice: 'Job was successfully created.' }
        # format.json { render :show, status: :created, location: @job }
      else
        # flash[:message] = "Validations here"\
        render :new
        # format.html { render :new }
        # format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    # end
  end

  def job_board
    @jobs = Job.all
  end

  def looking_for_students
    @jobs = Job.search(params[:search])
  end

  def looking_for_tutors
    @jobs = Job.search(params[:search])
  end

  def add_tutor_or_student
    @job = Job.find_by(id: params[:job_id])
    if @job.tutor == nil
      @job.tutor_id = current_user.id
      @job.save
    elsif @job.student == nil
      @job.student_id = currrent_user.id
      @job.save
    end
    redirect_to @job
  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_job
      @job = Job.find(params[:id])
    end

    def job_params(*args)
      params.require(:job).permit(*args)
    end

end
