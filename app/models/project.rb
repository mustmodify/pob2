class Project < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :client

  has_many :events
  has_many :assignments

  def to_s
    [client, name].join(' / ')
  end
end
