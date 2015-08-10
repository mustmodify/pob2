class CertsController < NestedCRUDController

  def target_on_create
    employee_certs_path( @employee )
  end

  def local_params
    params.require(:cert).permit(:description, :expires_on, :image).merge(:employee_id => @employee.id)
  end
end
