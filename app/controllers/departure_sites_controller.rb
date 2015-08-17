class DepartureSitesController < CRUDController
  def target_on_create
    departure_sites_path
  end

  def local_params
    params.require(:departure_site).permit(:name, :category, :details)
  end
end
