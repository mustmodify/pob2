class RestrictionsController < NestedCRUDController
  def target_on_create
    employee_restrictions_path(@employee)
  end 

  def local_params
    params.require(:restriction).permit(:title, :description, :effective_date, :attachment ).merge(employee_id: params[:employee_id])
  end

end
