class Project < ActiveRecord::Base

  belongs_to :oil_co
  belongs_to :customer

  belongs_to :departure_site
  belongs_to :work_site

end
