class CrewChangesController < CRUDController
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
