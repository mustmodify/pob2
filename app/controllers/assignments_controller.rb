class AssignmentsController < CRUDController
  private

  def target_on_destroy
    params[:return_to] || employees_path
  end

  def local_params
    params.fetch(:assignment, {}).permit(:employee_id, :project_id, :position_id)
  end
end
