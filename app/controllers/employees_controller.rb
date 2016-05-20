class EmployeesController < CRUDController
  def index
    @search = EmployeeSearch.new(params[:employee_search])
    @employees = @search.results.alphabetical.paginate(page: params[:page])
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
    if @employee.jobs.empty?
      @employee.destroy
      flash[:notice] = "Deleted employee #{@employee.name}"
      redirect_to employees_path
    else
      flash[:warning] = "Can't delete an employee who has been assigned jobs."
      redirect_to @employee
    end
  end

  def model
    Employee.alphabetical
  end

  def local_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :confirmed, :home_phone, :cell_phone, :alt_phone, :email, :dob, :nationality, :ssn, :gsn, :transportation_needed, :body_weight, :bag_weight, :status, :eligible_for_rehire, :picture, :street1, :street2, :city, :state, :zipcode, :ident_issuer, :ident_number, :ident_issue_date, :ident_expiration_date, :competencies_attributes => [:id, :position_id, :rate, :rate_interval, :_destroy], :position_ids => [])
  end
end
