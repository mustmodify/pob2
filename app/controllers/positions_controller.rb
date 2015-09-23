class PositionsController < CRUDController 

  def target_on_create
    positions_path
  end

  def local_params
    params.require(:position).permit(:name)
  end
end
