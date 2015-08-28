class EmployeeSearch < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  has_value :cert_expiration_period, :klass => :integer
  has_value :project_id, :klass => :integer

  def results
    scope = Employee.where('1=1')

    if self.project_id
      scope = scope.joins(:assignments)
      scope = scope.where('assignments.project_id = ?', self.project_id)
    end

    if self.cert_expiration_period
      scope = scope.joins(:certs)
      scope = scope.where('certs.expires_on < ?', Time.now + cert_expiration_period)
    end

    scope
  end

  def persisted?
    false
  end
end
