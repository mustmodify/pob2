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
end
