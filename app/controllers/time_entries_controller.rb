class TimeEntriesController < ApplicationController
  def new
    @employee = Employee.find(params[:employee_id])
    @assignments = @employee.assignments.order('id desc').limit(3)

    @time_entry = @employee.time_entries.build(assignment: @assignments.first, hours: 12)
  end

  def create
    @time_entry = TimeEntry.new(local_params)

    if @time_entry.save
      flash[:success] = "Created time entry #{@time_entry.to_s}"
      redirect_to new_employee_time_entry_path(@time_entry.employee)
    else
      render action: 'new'
    end
  end

  def index
    @employee = Employee.find(params[:employee_id])
    @time_entries = @employee.time_entries.order('date desc').paginate(page: params[:page])
  end

  def local_params
    params.fetch(:time_entry, {}).permit(:employee_id, :assignment_id, :date, :hours, :notes)
  end
end
