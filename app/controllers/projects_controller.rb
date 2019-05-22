class ProjectsController < CRUDController
  before_filter :set_scope

  def index
    @projects = Project.order('client, name').where(active: (params[:status] == 'active')).paginate(page: params[:page], per_page: 10)
  end

  def inactive
    @projects = Project.order('client, name').where(active: false)
  end

  def create
    @project = Project.new(local_params)

    if( @project.save )
      @project.events.create(user: current_user, action: "Created")
      redirect_to target_on_create
    else
      render action: 'new'
    end
  end

  def update
    @project = Project.find(params[:id])

    if( ProjectUpdateService.new(project: @project, changes: local_params, current_user: current_user).fire )
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
    params.fetch(:project, {}).permit(:name, :client, :active, :email, :phone)
  end

  def target_on_update
    projects_path(status: @project.active ? 'active' : 'inactive')
  end

  def target_on_create
    projects_path(status: @project.active ? 'active' : 'inactive')
  end
end
