class PagesController < ApplicationController
  before_filter :require_user, only: [:ssns]

  def ssns
    @employees = Employee.active.where('ssn IS NOT NULL')
  end

  def ops
    @projects = Project.active.sorted
    if(!params[:position_id].blank?)
      @employees = Employee.active.available.alphabetical.joins('left outer join competencies ON competencies.employee_id = employees.id').where('competencies.position_id = ?', params[:position_id])
    else
      @employees = Employee.active.available.alphabetical
    end

    render layout: 'fluid'
  end
end
