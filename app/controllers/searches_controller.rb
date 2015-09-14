class SearchesController < ApplicationController

  def new
  end

  def create
    show
  end

  def show 
    @search = Search.new(params[:search])
    render :action => 'show'
  end
end
