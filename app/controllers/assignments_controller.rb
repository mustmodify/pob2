class AssignmentsController < CRUDController
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.employee.update_attribute(:last_worked_on, Date.today)
    @assignment.destroy

    redirect_to target_on_destroy
  end

  private

  def target_on_destroy
    params[:return_to] || employees_path
  end

  def local_params
    params.fetch(:assignment, {}).permit(:employee_id, :project_id, :position_id)
  end
end
