class AssignmentsController < NestedCRUDController
  def target_on_create
    project_path(@project)
  end 

  def parent_model
    Project
  end

  def create
    @project = Project.find( params[:project_id] )

    @assignment = Assignment.new( local_params )
    @assignment.check_competence!

    if( @assignment.save )
      redirect_to target_on_create
    else
      render :action => 'new'
    end
  end

  def local_params
    params.fetch(:assignment, {}).permit(:employee_id, :position_id, :rate, :rate_interval, :po_number).merge(project_id: params[:project_id])
  end
end
