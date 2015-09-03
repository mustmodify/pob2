class POBTodayPresenter

  def initialize(atts)
    @project = atts.delete(:project)
    @date = (atts.delete(:date) || Date.today).to_date

    @pob_report = POBSummaryReport.new(
           start_date: @date,
             end_date: @date,
           project_id: @project.id)
  end

  def date
    @date
  end

  def title 
    case @date
    when Date.today - 1
      "Yesterday's POB Info"
    when Date.today
      "Today's POB Info"
    when Date.today + 1
      "Tomorrow's POB Info"
    else
      "POB Info for #{@date.to_s(:friendly)}"
    end 
  end

  def changes
    @pob_report.data.select {|datum| !datum.action(@date).nil? }
  end

  def onboard
    @pob_report.data.reject{|datum| datum.offboarding_date == @date }
  end

  def offboard
    @project.employees.active - onboard.map(&:employee)
  end
end
