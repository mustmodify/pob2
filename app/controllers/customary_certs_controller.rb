class CustomaryCertsController < CRUDController
  def index
    @position= Position.find(params[:position_id])
    @customary_certs = CustomaryCert.where(position_id: params[:position_id])
  end

  private

  def target_on_create
    position_customary_certs_path(@customary_cert.position)
  end

  def target_on_destroy
    position_customary_certs_path(@customary_cert.position)
  end

  def local_params
    p = params.fetch(:customary_cert, {}).permit(:position_id, :cert_name_id)
    p[:position_id] ||= params[:position_id]
    p
  end
end
