class CertsController < NestedCRUDController

  def index
    @employee = Employee.find params[:employee_id]
    @certs = @employee.certs.joins(:cert_name).order('cert_names.name')
  end

  def target_on_create
    employee_certs_path( @employee )
  end

  def local_params
    params.require(:cert).permit(:cert_name_id, :expires_on, :image).merge(:employee_id => @employee.id)
  end
end
