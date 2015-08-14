class OilCosController < CRUDController 

  def target_on_create
    oil_cos_path
  end

  def local_params
    params.require(:oil_co).permit(:name)
  end
end
