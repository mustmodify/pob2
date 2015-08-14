if ReprimandCategory.count == 0
  [ 
    'Tardiness',
    'Leaving Job Site Before Relief Arrives',
    'Absent from Work or Training',
    'Failure to Answer or Call Back at Reasonable Time',
    'Failure to Call the Day Before Crew Change',
    'Personal Problems Interfering with Work',
    'Failure to Follow Supervisors Instructions',
    'Failure to Follow Chain-of-Command',
    'Having to Leave the Job Before Crew Change',
    'Not Turning in Medical, Death, Court, Etc. Excuse',
    'Attitude',
    'Performance',
    'Creating a Disturbance',
    'Violation of Safety Rules',
    'Violation of Company Policies',
    'Willful Damage to Company Property',
    'Excuse For Not Going On a Job',
    'Other',
  ].each do |name|
    ReprimandCategory.create!(name: name)
  end
end

if User.count == 0
  User.create(email: 'jw@mustmodify.com',
         first_name: 'Johnathon',
          last_name: 'Wright',
             active: true,
    password_digest: "$2a$10$UsNvFntrm/cD15bHy/2LZ.4biQ0izM80Eij0ivPni42uC0ZUZSQbO")
end

if Position.count == 0
  Position.create(name: 'General Labor')
  Position.create(name: 'Crane Operator')
  Position.create(name: 'Rigger')
end
