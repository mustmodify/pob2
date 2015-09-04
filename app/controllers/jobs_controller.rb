class JobsController < CRUDController
  def index
    @parent = @employee =Employee.find_by_id( params[:employee_id] )
    @parent ||= @project = Project.find_by_id( params[:project_id] )

    @recent_jobs = @parent.jobs.where('offboarding_date > ?', 1.month.ago).where('offboarding_date < ?', Date.today).order('onboarding_date')
    @current_job = @parent.jobs.where('onboarding_date <= ?', Date.today).where('offboarding_date >= ?', Date.today).first
    @upcoming_jobs = @parent.jobs.where('onboarding_date > ?', Date.today).order('onboarding_date')
  end

  def target_on_create
    if params[:employee_id]
      employee_jobs_path( params[:employee_id] )
    else
      project_jobs_path( @job.project )
    end
  end

  def new
    @job = Job.new(local_params)
    @job.hours_per_day ||= 12
  end

  def local_params
    params.fetch(:job, {}).permit(:onboarding_date, :offboarding_date, :project_id, :employee_id, :position_id, :daily_rate, :hours_per_day, :note)
  end
end
