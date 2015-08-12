class ReprimandsController < NestedCRUDController

  def target_on_create
    employee_reprimands_path( @employee )
  end

  def local_params
    params.require(:reprimand).permit(:reprimand_category_id, :date, :note).merge(:employee_id => @employee.id)
  end
end
