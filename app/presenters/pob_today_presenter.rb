class POBTodayPresenter

  def initialize(atts)
    @project = atts.delete(:project)
    @date = atts.delete(:date) || Date.today

    @pob_report = POBSummaryReport.new(
           start_date: @date,
             end_date: @date,
           project_id: @project.id)
  end

  def title 
    case @date
    when Date.today + 1
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
    @pob_report.data.select {|datum| !datum.action.nil? }
  end

  def onboard
    @pob_report.data
  end

  def offboard
    @project.employees - onboard.map(&:employee) 
  end
end
