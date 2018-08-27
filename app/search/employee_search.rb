class EmployeeSearch < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  has_value :cert_expiration_period, :klass => :integer
  has_value :position_id, :klass => :integer
  has_value :include_those_needing_transport, :parse_with => lambda {|x| x == true || x == "true"}, default: true
  has_value :include_assigned, :parse_with => lambda {|x| x == true || x == "true"}, default: true
  has_value :status, default: 'Active'

  def results
    scope = Employee.where('1=1').group('employees.id')

    if self.cert_expiration_period
      scope = scope.joins(:certs)
      scope = scope.where('certs.expires_on < ?', Time.now + cert_expiration_period)
    end

    if position_id
      scope = scope.joins(:competencies).where('competencies.position_id = ?', position_id)
    end

    if !include_assigned
      scope = scope.where("assignment IS NULL OR assignment = ''")
    end

    if !self.include_those_needing_transport
      scope = scope.where('transportation_needed = ? OR transportation_needed IS NULL', false)
    end

    if self.status.not.blank?
      scope = scope.where(status: self.status)
    end

    if self.position_id
      scope.order('competencies.rating ASC')
    else
      scope.alphabetical
    end
  end

  def persisted?
    false
  end
end
