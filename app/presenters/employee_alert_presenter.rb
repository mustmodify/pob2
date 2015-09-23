class EmployeeAlertPresenter
  include ActionView::Helpers::DateHelper

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
        out << {:title => 'Expired Certs', :message => "The following certifications are out of date: #{employee.expired_certs.map do |cert|
           "#{cert.description} (#{cert.expires_on})"
        end.join(', ')}"}
      end

      if employee.ident_expiration_date && employee.ident_expiration_date <= Date.today
        if employee.ident_expiration_date.past?
          msg = "expired #{time_ago_in_words(employee.ident_expiration_date)} ago"
        else
          msg = "expires #{time_ago_in_words(employee.ident_expiration_date)} from now"
        end

        out << {:title => "Driver's Licence Expired", :message => "Please update the information on file for this employe's DL, which #{msg}."}
      end 
    end
  end
end
