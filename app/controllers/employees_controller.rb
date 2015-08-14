class EmployeesController < CRUDController
  def local_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :home_phone, :cell_phone, :alt_phone, :email, :dob, :nationality, :ssn, :gsn, :transportation_needed, :body_weight, :bag_weight, :eligible_for_rehire, :picture, :street1, :street2, :city, :state, :zipcode, :ident_issuer, :ident_number, :ident_issue_date, :ident_expiration_date, :position_ids => [])
  end
end
