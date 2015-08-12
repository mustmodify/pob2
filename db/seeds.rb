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
