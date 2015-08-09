class EmployeesController < CRUDController
  def local_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :home_phone, :cell_phone, :alt_phone_description, :alt_phone)
  end
end
