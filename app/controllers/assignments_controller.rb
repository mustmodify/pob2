class AssignmentsController < NestedCRUDController
  def target_on_create
    project_path(@project)
  end 

  def parent_model
    Project
  end

  def local_params
    params.require(:assignment).permit(:employee_id, :position_id, :daily_rate).merge(project_id: params[:project_id])
  end
end
