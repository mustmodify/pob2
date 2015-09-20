class CertNamesController < CRUDController
  def index
    @cert_names = CertName.order(:name)
  end

  def target_on_create
    cert_names_path
  end

  def local_params
    params.require(:cert_name).permit(:name)
  end
end
