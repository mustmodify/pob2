class CustomersController < CRUDController
  def target_on_create
    customers_path
  end

  def local_params
    params.require(:customer).permit(:name)
  end
end
