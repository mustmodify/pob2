class EmployeeUpdateService < Valuable
  has_value :employee
  has_value :changes

  def remember_changes
    @now_termed = employee.status_changed? && (employee.status == 'Terminated')
    @change_messages = ChangeNote.for(employee).map(&:to_s)
  end

  def change_messages
    @change_messages
  end

  def fire
    employee.assign_attributes(changes)
    remember_changes

    employee.save.tap do |success|
      if @now_termed
	employee.assignments.destroy_all
      end
    end
  end
end
