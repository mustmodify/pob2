class Search < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  has_value :term

  def safe_term
    term.gsub(/[^\w\d]/, '')
  end

  def employee_results
    if term =~ /^\d{4,9}$/
      Employee.where("cell_phone LIKE '%#{safe_term}' or home_phone LIKE '%#{safe_term}' or alt_phone LIKE '%#{safe_term}'")
    elsif term =~ /^\d{10}$/
      Employee.where("cell_phone LIKE '#{safe_term}' or home_phone LIKE '#{safe_term}' or alt_phone LIKE '#{safe_term}'")
    else
      Employee.where("first_name LIKE '#{safe_term}%' or last_name LIKE '#{safe_term}%'")
    end
  end

  def results
    employee_results
  end

  def persisted?
    false
  end
end
