require 'spec_helper'

describe Assignment do
  it 'is valid given valid attributes' do
    FactoryGirl.build(:assignment).should be_valid
  end

  it 'prevents employees from doing things they can not' do
    jed = FactoryGirl.create(:employee)
    other_position = FactoryGirl.create(:position)

    FactoryGirl.build(:assignment, employee: jed, position: other_position).should_not be_valid
  end
end
