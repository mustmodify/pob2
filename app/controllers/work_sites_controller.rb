class WorkSitesController < CRUDController
  def target_on_create
    work_sites_path
  end

  def local_params
    params.fetch(:work_site, {}).permit(:name, :details)
  end
end
