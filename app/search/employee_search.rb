class EmployeeSearch < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  has_value :cert_expiration_period, :klass => :integer
  has_value :project_id, :klass => :integer
  has_value :position_id, :klass => :integer
  has_value :include_those_needing_transport, :parse_with => lambda {|x| x == true || x == "true"}, default: true
  has_value :status

  def results
    scope = Employee.where('1=1')

    if self.project_id || self.position_id
      scope = scope.joins(:assignments)
      scope = scope.where('assignments.project_id = ?', self.project_id) if project_id
      scope = scope.where('assignments.position_id = ?', self.position_id) if position_id
    end

    if self.cert_expiration_period
      scope = scope.joins(:certs)
      scope = scope.where('certs.expires_on < ?', Time.now + cert_expiration_period)
    end

    if !self.include_those_needing_transport
      scope = scope.where('transportation_needed = ? OR transportation_needed IS NULL', false)
    end

    if self.status.not.blank?
      scope = scope.where(status: self.status)
    end

    scope
  end

  def persisted?
    false
  end
end
