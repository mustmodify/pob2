class ProjectsController < CRUDController
  def model
    Project.alphabetical
  end

  def local_params
    params.fetch(:project, {}).permit(:name, :oil_co_id, :customer_id, :departure_site_id, :work_site_id, :start_date, :end_date, :phone, :email)
  end
end
