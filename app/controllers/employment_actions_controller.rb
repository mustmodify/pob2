class EmploymentActionsController < CRUDController
  before_action :load_employee, except: [:destroy]

  def show
  end

  def new
    @employment_action = EmploymentAction.new(local_params.merge(employee_id: params[:employee_id]))
  end

  def destroy
    @employment_history = EmploymentHistory.find(params[:id])
    @employment_history.update(deleted: true)

    redirect_to target_on_destroy
  end

  private

  def target_on_create
    employee_history_path(@employee)
  end

  def target_on_destroy
    employee_history_path(@employment_action.employee)
  end

  def load_employee
    @employee = Employee.find(params[:employee_id])
  end

  def local_params
    params.fetch(:employment_action, {}).permit(:employee_id, :action, :notes, :date)
  end
end
