class AssignmentsController < CRUDController
  def show
    # This happens when someone tries to change an assignment but
    # they were logged out and then when they log back in, they get
    # GET instead of POST/PUT/DELETE.
    redirect_to request.referrer || params[:return_to] || root_path
  end

  def create
    @assignment = Assignment.new(local_params)
    @assignment.start_date ||= Date.today

    redirect_to target_on_create
  end

  def destroy
    @assignment = Assignment.find_by_id(params[:id])

    if @assignment
      @assignment.employee.update_attribute(:last_worked_on, Date.today)
      @assignment.destroy
    end

    redirect_to target_on_destroy
  end

  private

  def target_on_destroy
    params[:return_to] || employees_path
  end

  def local_params
    params.fetch(:assignment, {}).permit(:employee_id, :project_id, :position_id, :start_date, :end_date)
  end
end
