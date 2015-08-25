class CrewChangesController < CRUDController

  def index
    @crew_changes = CrewChange.order('date asc')
    @crew_changes = @crew_changes.where(project_id: params[:project_id]) if params[:project_id]

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
