class CompetencyValidator < ActiveModel::Validator
  def validate( assignment )
    assignment.errors[:position] << "is not on the list of competencies for this employee." unless assignment.competency
  end
end
