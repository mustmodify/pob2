class ReportsController < ApplicationController

  def pob_summary
    @pob_summary = POBSummaryReport.new( params[:pob_summary_report] )
    @pob_summary.require_params = true

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'pob_summary', layout: 'application.pdf'
      end
    end
  end

  def calendar
    respond_to do |format|
      format.html { render :layout => 'wide'}
      format.json { render :json => CrewChangeReport.search(params[:start], params[:end]).to_json }
    end
  end

  def timesheet
    @timesheet = TimesheetPresenter.new( params[:timesheet_presenter] )

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'timesheet', layout: 'application.pdf'
      end
    end
  end

  def year_end
    @report = YearEndReport.new( params[:year_end_report] )

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'year_end', layout: 'application.pdf'
      end
    end
  end
end
