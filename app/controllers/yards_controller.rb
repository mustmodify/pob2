class YardsController < CRUDController
  def target_on_create
    yards_path
  end

  def local_params
    params.require(:yard).permit(:name)
  end
end
