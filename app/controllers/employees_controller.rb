class EmployeesController < CRUDController
  def local_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :home_phone, :cell_phone, :alt_phone_description, :alt_phone)
  end

  def show
    redirect_to edit_employee_path( params[:id] )
  end

  def target_on_create
    edit_employee_path(@employee)
  end
end
