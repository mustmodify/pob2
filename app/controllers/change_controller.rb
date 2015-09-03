class ChangeController < ApplicationController
  def new
    @job = Job.find params[:job_id]
    @change = Change.new(local_params)
  end

  def create
    @job = Job.find params[:job_id]
    @change = Change.new(local_params)

    if @change.valid?
      @change.fire
      redirect_to employee_path(@change.employee_id), notice: 'Change has been made.'
    else
      render action: 'new'
    end
  end

  def local_params
    p = params.fetch(:change, {}).permit(:job_id, :date, :hours_worked, :note)
    p[:job_id] ||= params[:job_id]
    p
  end
end
