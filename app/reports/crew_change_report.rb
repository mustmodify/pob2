class CrewChangeReport < Valuable
  has_value :date
  has_value :project
  has_value :onboardings
  has_value :offboardings

  def self.search(start_date, end_date)

    data = Q.ask %|
     SELECT project_id, date, SUM(onboarding) as onboardings, 
            SUM(offboarding) as offboardings 
       FROM
            ( 
                  SELECT jobs.id, jobs.project_id, 1 as onboarding,
                         0 as offboarding, jobs.onboarding_date as date
                    FROM jobs
              LEFT OUTER JOIN jobs doublecheck
                           ON doublecheck.id != jobs.id
                          AND doublecheck.project_id = jobs.project_id
                          AND doublecheck.employee_id = jobs.employee_id
                          AND doublecheck.offboarding_date = jobs.onboarding_date
                   WHERE doublecheck.id IS NULL 
                     AND jobs.onboarding_date >= DATE('#{start_date.to_date.to_s(:db)}')
                     AND jobs.onboarding_date <= DATE('#{  end_date.to_date.to_s(:db)}')
                     AND jobs.onboarding_date != jobs.offboarding_date
        
            UNION 

                  SELECT jobs.id, jobs.project_id, 0 as onboarding,
                         1 as offboarding, jobs.offboarding_date as date
                    FROM jobs
              LEFT OUTER JOIN jobs doublecheck
                           ON doublecheck.id != jobs.id
                          AND doublecheck.project_id = jobs.project_id
                          AND doublecheck.employee_id = jobs.employee_id
                          AND doublecheck.onboarding_date = jobs.offboarding_date
                   WHERE doublecheck.id IS NULL 
                     AND jobs.offboarding_date >= DATE('#{start_date.to_date.to_s(:db)}')
                     AND jobs.offboarding_date <= DATE('#{  end_date.to_date.to_s(:db)}')
                     AND jobs.offboarding_date != jobs.onboarding_date
            ) as shimmy
   GROUP BY project_id, date|

    data.map do |datum|
      new(
        date: datum['date'],
        project: Project.where(id: datum['project_id']).first,
        onboardings: datum['onboardings'],
        offboardings: datum['offboardings'],
      )
    end.flatten
  end

  def self.for( project, date )
    new(
          project: project,
             date: date,
      onboardings: Job.where(onboarding_date: (start_date..end_date)).where(onboarding_date != offboarding_date).count,
     offboardings: Job.where(offboarding_date: (start_date..end_date)).where(onboarding_date != offboarding_date).count
    )
  end

  def as_json(options = {})
    {
      title: "#{self.project.name} +#{onboardings} -#{offboardings}",
      allDay: true,
      start: date.to_date.to_s(:db),
      url: "/projects/#{self.project.id}?date=#{date.to_date.to_s(:db)}"
    }
  end
end
