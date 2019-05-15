class AssignmentsController < CRUDController
  private

  def local_params
    params.fetch(:assignment, {}).permit(:employee_id, :project_id, :position_id)
  end
end
