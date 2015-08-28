class CertNamesController < CRUDController
  def target_on_create
    cert_names_path
  end

  def local_params
    params.require(:cert_name).permit(:name)
  end
end
