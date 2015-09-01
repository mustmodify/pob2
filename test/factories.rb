FactoryGirl.define do
  factory :assignment do
    association :project
    association :employee
    association :position

    daily_rate 150
  end

  factory :cert do
    association :employee
    description 'This cert comes from the factory'
    image_file_name 'text.png'
    image_content_type 'image/png'
    image_file_size '1024'
  end

  factory :competency do
    association :employee
    association :position
    rate 100
  end

  factory :employee do
    first_name 'John'
    last_name 'Watzke'
  end

  factory :job do
    association :project
    association :employee
    association :position
    onboarding_date { 3.days.ago }
    offboarding_date { 3.days.ago }
  end

  factory :position do
    name {"#{String.random(5)} Position"}
  end

  factory :project do
    name { "#{String.random(5)} Project" }
  end
end
