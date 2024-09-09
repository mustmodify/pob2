class TimeAnalysesController < ApplicationController
  def show
    @employee = Employee.find(params[:employee_id])

    @yearly_results = TimeAnalysisPresenter.yearly_results(@employee.id)
    @quarterly_results = TimeAnalysisPresenter.quarterly_results(@employee.id)
  end
end
