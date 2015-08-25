FactoryGirl.define do
  factory :cert do
    association :employee
    description 'This cert comes from the factory'
    image_file_name 'text.png'
    image_content_type 'image/png'
    image_file_size '1024'
  end

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
