class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new

  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create

    @job = Job.new(job_params(:description, :location, :time, :rate, :topic_id))

    if params[:job][:type_of_user] == "Student"
      @job.student_id = current_user.id
    elsif params[:job][:type_of_user] == "Tutor"
      @job.tutor_id = current_user.id
    end

    # respond_to do |format|
      if @job.save

        redirect_to '/job_board', notice: 'Successfully posted your job'
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

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
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


  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params(*args)
      params.require(:job).permit(*args)
    end

end
