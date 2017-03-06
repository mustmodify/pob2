class PositionsController < CRUDController 

  def show
    @position = Position.find(params[:id])
    render :layout => 'fluid'
  end

  def target_on_create
    positions_path
  end

  def local_params
    params.fetch(:position, {}).permit(:name)
  end
end
