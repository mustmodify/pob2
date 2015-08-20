class CrewChangesController < CRUDController

  def index
    @project = Project.find( params[:project_id] )
    @crew_changes = @project.crew_changes.order('date desc')

    respond_to do |format|
      format.json { }
      format.html { @crew_changes = @crew_changes.paginate(page: params[:page]) }
    end
  end

  def target_on_create
    project_path( @crew_change.project )
  end

  def new
    @crew_change = CrewChange.new(local_params)
  end

  def local_params
    params.fetch(:crew_change, {}).permit(:date, :project_id, :action, :employee_id, :position_id, :rate)
  end
end
