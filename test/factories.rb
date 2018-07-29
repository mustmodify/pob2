FactoryGirl.define do
  factory :cert do
    association :employee
    association :cert_name
    image_file_name 'text.png'
    image_content_type 'image/png'
    image_file_size '1024'
  end

  factory :cert_name do
    name 'This cert comes from the factory'
  end

  factory :competency do
    association :employee
    association :position
    rate 100
    rate_interval 'day'
  end

  factory :employee do
    first_name 'John'
    last_name 'Watzke'
  end

  factory :position do
    name {"#{String.random(5)} Position"}
  end
end
