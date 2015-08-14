class HeliportsController < CRUDController
  def target_on_create
    heliports_path
  end

  def local_params
    params.require(:heliport).permit(:name)
  end
end
