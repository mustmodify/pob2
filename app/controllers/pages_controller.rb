class PagesController < ApplicationController
  before_filter :require_user, only: [:ssns]

  def ssns
    @employees = Employee.where('ssn IS NOT NULL')
  end
end
