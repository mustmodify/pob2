class ClientsController < CRUDController
  before_filter :set_scope

  def index
    @clients = Client.order('active, name').where(active: (params[:status] == 'active')).paginate(page: params[:page], per_page: 10)
  end

  def create
    @client = Client.new(local_params)

    if( @client.save )
      redirect_to target_on_create
    else
      render action: 'new'
    end
  end

  def update
    @client = Client.find(params[:id])

    if( ClientUpdateService.new(client: @client, changes: local_params, current_user: current_user).fire )
      redirect_to target_on_update
    else
      render action: 'edit'
    end
  end

  private

  def set_scope
    params[:status] ||= 'active'
  end

  def local_params
    params.fetch(:client, {}).permit(:name, :active)
  end

  def target_on_update
    clients_path(status: @client.active ? 'active' : 'inactive')
  end

  def target_on_create
    clients_path(status: @client.active ? 'active' : 'inactive')
  end

  def target_on_destroy
    clients_path
  end
end
