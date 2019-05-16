class PositionsController < CRUDController

  def index
    @positions = Position.alphabetical
  end

  def show
    @position = Position.find(params[:id])
    render :layout => 'fluid'
  end

  def target_on_create
    positions_path
  end

  def local_params
    params.fetch(:position, {}).permit(:name, :color)
  end
end
