class Project < ActiveRecord::Base
  extend Model

  validates_presence_of :name
  validates_presence_of :client

  has_many :events, :dependent => :destroy
  has_many :assignments, :dependent => :destroy

  stringly :phone
  stringly :email, max_length: 120

  def to_s
    [client, name].join(' / ')
  end

  scope :sorted, -> {order('client, name')}
  scope :active, -> {where(active: true)}
end
