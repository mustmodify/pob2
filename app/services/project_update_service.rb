class ProjectUpdateService < Valuable
  has_value :project
  has_value :changes
  has_value :current_user

  def remember_changes
    @change_messages = ChangeNote.for(project).map(&:to_s)
  end

  def change_messages
    @change_messages
  end

  def note_changes
    change_messages.each do |m|
      project.events.create(action: m, user: current_user)
    end
  end

  def fire
    project.assign_attributes(changes)
    remember_changes

    project.save.tap do |success|
      note_changes
    end
  end
end
