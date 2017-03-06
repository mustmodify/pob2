class OilCosController < CRUDController 

  def target_on_create
    oil_cos_path
  end

  def local_params
    params.fetch(:oil_co, {}).permit(:name)
  end
end
