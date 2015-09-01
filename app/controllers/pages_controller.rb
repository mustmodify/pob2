class PagesController < ApplicationController
  def dashboard
    @projects = Project.visible
  end
end
