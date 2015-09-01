class CrewChangeReport < Valuable
  has_value :date
  has_value :project
  has_collection :onboardings
  has_collection :offboardings

  def self.search(start_date, end_date)
    scope = Job.where('onboarding_date != offboarding_date')

    (start_date..end_date).to_a.map do |date|
      Project.all.map do |project|
        onboardings = scope.where(project_id: project.id, onboarding_date: date)
        offboardings = scope.where(project_id: project.id, offboarding_date: date)

        next if onboardings.empty? && offboardings.empty?

        new(
          date: date,
          project: project,
          onboardings: onboardings,
          offboardings: offboardings,
        )
      end.flatten
    end.flatten.compact
  end

  def self.for( project, date )
    new(
          project: project,
             date: date,
      onboardings: Job.where(onboarding_date: (start_date..end_date)).where(onboarding_date != offboarding_date),
     offboardings: Job.where(offboarding_date: (start_date..end_date)).where(onboarding_date != offboarding_date)
    )
  end

  def as_json(options = {})
    {
      title: "#{self.project.name} +#{onboardings.count} -#{offboardings.count}",
      allDay: true,
      start: date.to_date.to_s(:db),
      url: "/projects/#{self.project.id}?date=#{date.to_date.to_s(:db)}"
    }
  end
end
