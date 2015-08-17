class ProjectsController < CRUDController
  def local_params
    params.require(:project).permit(:name, :oil_co_id, :customer_id, :departure_site_id, :work_site_id, :start_date, :end_date)
  end
end
