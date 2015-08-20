class ComplimentsController < NestedCRUDController
  def target_on_create
    employee_compliments__path(@employee)
  end 

  def local_params
    params.require(:compliments).permit(:date, :note).merge(employee_id: params[:employee_id])
  end

end
