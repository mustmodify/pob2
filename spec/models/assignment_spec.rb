require 'spec_helper'

describe Assignment do
  it 'is valid given valid attributes' do
    FactoryGirl.build(:assignment).should be_valid
  end

  it 'does not allow duplication of project-employee-position' do
    original = FactoryGirl.create(:assignment)
    dup = FactoryGirl.build(:assignment, 
                employee: original.employee,
                project: original.project,
                position: original.position
          )

    dup.should_not be_valid
  end

  it 'CAN prevent assigning employees to roles for which they are not qualified' do
    a = FactoryGirl.build(:assignment)
    a.should be_valid
    a.check_competence!
    a.should_not be_valid
    FactoryGirl.create(:competency, employee: a.employee, position: a.position)
    a.should be_valid
  end
end
