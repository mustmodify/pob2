FactoryGirl.define do
  factory :crew_change do
    association :project
    association :employee
    date { 3.days.ago }
    association :position
    action 'In'
    rate 100
  end

  factory :employee do
    first_name 'John'
    last_name 'Watzke'
  end

  factory :position do
    name {"#{String.random(5)} Position"}
  end

  factory :project do
    name { "#{String.random(5)} Project" }
  end
end
