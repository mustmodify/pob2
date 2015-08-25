class ReportsController < ApplicationController

  def pob_summary
    @pob_summary = POBSummaryReport.new( params[:pob_summary_report] )
    @pob_summary.require_params = true
  end
end
