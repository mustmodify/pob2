class JobsController < CRUDController

  def target_on_create
    project_path( @job.project )
  end

  def new
    @job = Job.new(local_params)
  end

  def local_params
    params.fetch(:job, {}).permit(:onboarding_date, :offboarding_date, :project_id, :employee_id, :position_id, :daily_rate, :note)
  end
end
