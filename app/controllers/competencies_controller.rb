class CompetenciesController < ApplicationController
  def index 
    @employee = Employee.find(params[:employee_id])

    Position.all.map do |position|
      if !@employee.competencies.map(&:position_id).include? position.id
        @employee.competencies.build( employee_id: params[:employee_id], position_id: position.id )
      end
    end
  end
end
