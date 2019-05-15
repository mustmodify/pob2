class EmployeesController < CRUDController
  def index
    @search = EmployeeSearch.new(params[:employee_search])
    @employees = @search.results.paginate(page: params[:page])
  end

  def create
    @employee = Employee.new( local_params )

    if( @employee.doppelgangers.not.empty? && (@employee.confirmed != '1') )
      render :action => 'confirmation'
    elsif @employee.save
      redirect_to target_on_create
    else
      render action: 'new'
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    if @employee.assignments.empty?
      @employee.destroy
      flash[:notice] = "Deleted employee #{@employee.name}"
      redirect_to employees_path
    else
      flash[:warning] = "Can't delete an employee who is currently assigned to a project"
      redirect_to @employee
    end
  end

  def update
    set_record model.find(params[:id])

    if instance.update_attributes( local_params )
      respond_to do |format|
        format.html { redirect_to target_on_update }
        format.json { render :json => instance.to_json }
        format.xml  { render :xml => instance.to_xml }
      end
    else
      respond_to do |format|
        format.html {
          if params[:employee][:competencies_attributes]
            render template: '/competencies/index'
          else
            render action: 'edit'
          end
        }

        format.json { render :json => instance.errors, :status => :unprocessable_enti
ty }
        format.xml { render :xml => instance.errors, :status => :unprocessable_entity
 }
      end
    end
  end

  private

  def model
    Employee.alphabetical
  end

  def local_params
    params.fetch(:employee, {}).permit(:first_name, :middle_name, :last_name, :confirmed, :home_phone, :cell_phone, :alt_phone, :email, :dob, :nationality, :ssn, :gsn, :body_weight, :bag_weight, :status, :eligible_for_rehire, :picture, :street1, :street2, :city, :state, :zipcode, :ident_issuer, :ident_number, :ident_issue_date, :ident_expiration_date, :assignment, :competencies_attributes => [:id, :position_id, :rating, :rate, :rate_interval, :_destroy], :position_ids => [])
  end
end
