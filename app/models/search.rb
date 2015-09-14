class Search < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  has_value :term

  def safe_term
    term.gsub(/[^\w\d]/, '')
  end

  def employee_results
    Employee.where("first_name LIKE '#{safe_term}%' or last_name LIKE '#{safe_term}%'")
  end

  def project_results
    Project.where("name LIKE '%#{safe_term}%'")
  end

  def results
    employee_results + project_results
  end

  def persisted?
    false
  end
end
