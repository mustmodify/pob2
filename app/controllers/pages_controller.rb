class PagesController < ApplicationController
  def dashboard
    @ongoing_projects = Project.joins(:jobs).where('jobs.onboarding_date <= ? AND jobs.offboarding_date >= ?', Date.today, Date.today).order('projects.name').uniq

    @projects = Project.visible.where('projects.id NOT IN (?)', @ongoing_projects.pluck(:id) ).order('projects.name')
  end
end
