class ScreeningsController < NestedCRUDController
  def collection
    @screenings.order('date desc')
  end

  def target_on_create
    employee_screenings_path(@employee)
  end

  def local_params
    params.fetch(:screening, {}).permit(:category, :outcome, :date, :image).merge(employee_id: params[:employee_id])
  end

end
