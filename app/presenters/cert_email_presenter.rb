class CertEmailPresenter < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  has_value :employee, klass: Employee, parse_with: :find, :alias => :employee_id
  has_collection :cert_ids, :klass => :integer
  has_value :recipient

  validate :must_have_recipient
  validate :must_have_some_certs

  def employee_id
    self.employee.id
  end

  def certs
    Cert.where(employee_id: self.employee_id, id: self.cert_ids.compact)
  end

  def must_have_recipient
    errors[:recipient] << "is not a valid email address" unless self.recipient && self.recipient =~ EMAIL_PATTERN
  end

  def must_have_some_certs
    errors[:cert_ids] << "must not be empty" if self.cert_ids.empty?
  end

  def persisted?
    false
  end
end
