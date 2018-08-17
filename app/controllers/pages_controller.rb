class PagesController < ApplicationController
  before_filter :require_user, only: [:ssns]

  def ssns
    @ssns = Employee.where('ssn IS NOT NULL').pluck(:ssn)
  end
end
