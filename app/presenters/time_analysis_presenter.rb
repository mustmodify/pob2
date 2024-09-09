class TimeAnalysisPresenter < Valuable
  has_value :employee_id
  has_value :employee_name
  has_value :project_name
  has_value :year
  has_value :quarter
  has_value :project_hours
  has_value :percentage_of_total

  def self.yearly_data(employee_id)
    conditions = nil
    e_join = nil

    if(employee_id)
      conditions = " WHERE te.employee_id = #{employee_id} "
      e_join = " AND e.id = #{employee_id} "
    end

    Q.ask %|
      SELECT
        e.id as employee_id,
        CONCAT(CONCAT(e.first_name, ' '), e.last_name) as employee_name,
        p.name as project_name,
        eph.year,
        eph.project_hours,
        ROUND((eph.project_hours / eth.total_hours) * 100, 2) AS percentage_of_total
      FROM
        (SELECT
           te.employee_id,
           a.project_id,
           YEAR(te.date) AS year,
           SUM(te.hours) AS project_hours
         FROM
           time_entries te
         JOIN
           assignments a ON te.assignment_id = a.id
         #{conditions}
         GROUP BY
           te.employee_id, a.project_id, YEAR(te.date)) eph
      JOIN
        (SELECT
           te.employee_id,
           YEAR(te.date) AS year,
           SUM(te.hours) AS total_hours
         FROM
           time_entries te
         #{conditions}
         GROUP BY
           te.employee_id, YEAR(te.date)) eth
        ON eph.employee_id = eth.employee_id AND eph.year = eth.year
      JOIN
        employees e ON eph.employee_id = e.id
        #{e_join}
      JOIN
        projects p ON eph.project_id = p.id
      ORDER BY
        eph.year, e.last_name, e.first_name, eph.project_hours

    |
  end

  def self.yearly_results(employee_id)
    yearly_data(employee_id).map do |data|
      new(data)
    end
  end

  def self.quarterly_data(employee_id)
    conditions = " WHERE QUARTER(te.date) = QUARTER(CURDATE()) "
    simpler_conditions = nil
    e_join = nil

    if(employee_id)
      conditions += " AND te.employee_id = #{employee_id} "
      simpler_conditions = " WHERE e.id = #{employee_id} "
      e_join = " AND e.id = #{employee_id} "
    end

    Q.ask %|
      SELECT
        e.id as employee_id,
        CONCAT(CONCAT(e.first_name, ' '), e.last_name) as employee_name,
        p.name as project_name,
        eph.year,
        eph.quarter,
        eph.project_hours,
        ROUND((eph.project_hours / eth.total_hours) * 100, 2) AS percentage_of_total
      FROM
        (SELECT
           te.employee_id,
           a.project_id,
           YEAR(te.date) AS year,
           QUARTER(te.date) AS quarter,
           SUM(te.hours) AS project_hours
         FROM
           time_entries te
         JOIN
           assignments a ON te.assignment_id = a.id
         #{conditions}
         GROUP BY
           te.employee_id, a.project_id, YEAR(te.date), QUARTER(te.date)) eph
      JOIN
        (SELECT
           te.employee_id,
           YEAR(te.date) AS year,
           QUARTER(te.date) AS quarter,
           SUM(te.hours) AS total_hours
         FROM
           time_entries te
         #{conditions}
         GROUP BY
           te.employee_id, YEAR(te.date), QUARTER(te.date)) eth
        ON eph.employee_id = eth.employee_id AND eph.year = eth.year AND eph.quarter = eth.quarter
      JOIN
        employees e ON eph.employee_id = e.id
      JOIN
        projects p ON eph.project_id = p.id
      #{simpler_conditions}
      ORDER BY
        eph.year, eph.quarter, e.last_name, e.first_name, eph.project_hours

    |
  end

  def self.quarterly_results(employee_id)
    quarterly_data(employee_id).map do |data|
      new(data)
    end
  end
end

