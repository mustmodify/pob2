class PagesController < ApplicationController
  before_filter :require_user, only: [:ssns]

  def ssns
    @employees = Employee.active.where('ssn IS NOT NULL')
  end

  def ops
    @projects = Project.active.sorted
    @employees = Employee.active.available.alphabetical
    render layout: 'fluid'
  end
end
