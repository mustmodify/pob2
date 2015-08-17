class CrewChangesController < CRUDController
  def target_on_create
    projects_path( @crew_change.project )
  end

  def local_params
    params.require(:crew_change).permit(:date, :project_id, :action, :employee_id, :position_id, :rate)
  end
end
