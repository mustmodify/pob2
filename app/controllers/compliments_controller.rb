class ComplimentsController < NestedCRUDController
  def target_on_create
    employee_compliments_path(@employee)
  end 

  def local_params
    params.require(:compliment).permit(:date, :note, :image).merge(employee_id: params[:employee_id])
  end

end
