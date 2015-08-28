class CrewChangeReport < Valuable
  has_value :date
  has_value :project
  has_collection :changes

  def self.search(start_date, end_date)
    CrewChange.where(date: (start_date..end_date)).group_by(&:date).map do |date, changes|
      changes.group_by(&:project).map do |project, clist|
        new(date: date, project: project, changes: clist) 
      end.flatten
    end.flatten
  end

  def self.for( project, date )
    new(project: project, date: date, changes: CrewChange.where(date: date, project_id: project.id)).tap do |obj|
    end
  end

  def count_in
    changes.select{|c| c.action == 'In'}.size
  end

  def count_out
    changes.select{|c| c.action == 'Out'}.size
  end

  def as_json(options = {})
    {
      title: "#{self.project.name} +#{count_in} -#{count_out}",
      allDay: true,
      start: date.to_date.to_s(:db),
    }
  end
end
