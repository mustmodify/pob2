class EmployeeAlertPresenter

  def initialize(emp)
    @employee = emp
  end

  def employee
    @employee
  end

  def alerts
    @alerts ||= generate_alerts
  end

  def generate_alerts
    [].tap do |out|
      if employee.expired_certs.size > 0
        out << {:title => 'Expired Certs', :message => "The following certifications are out of date: #{employee.expired_certs.map(&:description).join(', ')}"}
      end

      if employee.ident_expiration_date && employee.ident_expiration_date <= Date.today
        out << {:title => "Driver's Licence Expired", :message => "Please update the information on file for this employe's DL."}
      end 
    end
  end
end
