class TimeAnalysisPresenter < Valuable
  has_value :employee_id
  has_value :employee_name
  has_value :client_name
  has_value :year
  has_value :quarter
  has_value :hours
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
        clients.name as client_name,
        eph.year,
        eph.hours,
        ROUND((eph.hours / eth.total_hours) * 100, 2) AS percentage_of_total
      FROM
        (SELECT
           te.employee_id,
           p.client_id,
           YEAR(te.date) AS year,
           SUM(te.hours) AS hours
         FROM
           time_entries te
         JOIN
           assignments a ON te.assignment_id = a.id
         JOIN
           projects p ON p.id = a.project_id
         #{conditions}
         GROUP BY
           te.employee_id, p.client_id, YEAR(te.date)) eph
      JOIN
        (  SELECT
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
        clients ON eph.client_id = clients.id
      ORDER BY
        eph.year, e.last_name, e.first_name, eph.hours

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
        clients.name as client_name,
        eph.year,
        eph.quarter,
        eph.hours,
        ROUND((eph.hours / eth.total_hours) * 100, 2) AS percentage_of_total
      FROM
        (SELECT
           te.employee_id,
           p.client_id,
           YEAR(te.date) AS year,
           QUARTER(te.date) AS quarter,
           SUM(te.hours) AS hours
         FROM
           time_entries te
         JOIN
           assignments a ON te.assignment_id = a.id
         JOIN
           projects p ON p.id = a.project_id
         #{conditions}
         GROUP BY
           te.employee_id, p.client_id, YEAR(te.date), QUARTER(te.date)) eph
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
        clients ON eph.client_id = clients.id
      #{simpler_conditions}
      ORDER BY
        eph.year, eph.quarter, e.last_name, e.first_name, eph.hours

    |
  end

  def self.quarterly_results(employee_id)
    quarterly_data(employee_id).map do |data|
      new(data)
    end
  end
end

