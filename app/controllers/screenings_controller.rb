class ScreeningsController < NestedCRUDController
  def target_on_create
    employee_screenings_path(@employee)
  end 

  def local_params
    params.require(:screening).permit(:category, :outcome, :date, :image).merge(employee_id: params[:employee_id])
  end

end
