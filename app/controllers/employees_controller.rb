class EmployeesController < CRUDController
  def index
    @search = EmployeeSearch.new(params[:employee_search])
    @employees = @search.results.alphabetical.paginate(page: params[:page])
  end

  def model
    Employee.alphabetical
  end

  def local_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :home_phone, :cell_phone, :alt_phone, :email, :dob, :nationality, :ssn, :gsn, :transportation_needed, :body_weight, :bag_weight, :status, :eligible_for_rehire, :picture, :street1, :street2, :city, :state, :zipcode, :ident_issuer, :ident_number, :ident_issue_date, :ident_expiration_date, :competencies_attributes => [:id, :position_id, :rate, :_destroy], :position_ids => [])
  end
end
