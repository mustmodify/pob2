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

if WorkSite.count == 0
  WorkSite.create(name: 'Fourchon')
  WorkSite.create(name: 'Galveston')
  WorkSite.create(name: 'GulfMark Youngsville')
  WorkSite.create(name: 'Halliburton Lafayette')
  WorkSite.create(name: 'Houma Reclamation Field', :details => "112 Main St.\nHouma, LA 70363")
  WorkSite.create(name: 'Mid-South Rental and Completions')
end

if DepartureSite.count == 0
  DepartureSite.create(name: 'South New Rhodes Heliport', category: 'Heliport')
  DepartureSite.create(name: 'North New Rhodes Heliport', category: 'Heliport')
  DepartureSite.create(name: 'ERA', category: 'Heliport')
  DepartureSite.create(name: 'C-Port 1, Slip 1', category: 'Dock')
  DepartureSite.create(name: 'C-Port 1, Slip 5', category: 'Dock')
  DepartureSite.create(name: 'C-Terminal', category: 'Dock')
  DepartureSite.create(name: 'Haliburton', category: 'Dock')
  DepartureSite.create(name: 'Offshore Support Services', category: 'Dock')
end

if Customer.count == 0
  Customer.create(name: 'GulfMark')
  Customer.create(name: 'Tidewater')
  Customer.create(name: 'Aries Marine')
  Customer.create(name: 'Adriatic Marine')
  Customer.create(name: 'Mid South Rentals & Completions')
  Customer.create(name: 'Baker Hughes: Broussard')
  Customer.create(name: 'AFS PetroLogix')
  Customer.create(name: 'Seacor Marine')
  Customer.create(name: 'SeaTran')
end

if OilCo.count == 0
  OilCo.create(name: 'Anadarko')
  OilCo.create(name: 'Hess')
  OilCo.create(name: 'BP')
  OilCo.create(name: 'Marubeni')
  OilCo.create(name: 'Chevron')
  OilCo.create(name: 'Shell')
  OilCo.create(name: 'LLOG')
  OilCo.create(name: 'W&T')
  OilCo.create(name: 'Energy XXI')
  OilCo.create(name: 'McMoran')
  OilCo.create(name: 'Exxon')
end
