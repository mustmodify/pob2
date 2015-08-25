class EmployeeSearch < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  has_value :cert_expiration_period, :klass => :integer

  def results
    scope = Employee.where('1=1')

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
