class TimeAnalysesController < ApplicationController
  def show
    @employee = Employee.find_by_id(params[:employee_id])

    @yearly_results = TimeAnalysisPresenter.yearly_results(params[:employee_id])
    @quarterly_results = TimeAnalysisPresenter.quarterly_results(params[:employee_id])
  end
end
