class CertName < ActiveRecord::Base
  validates_presence_of :name

  has_many :certs
  has_many :customary_certs

  def to_s
    name
  end

  def removable?
    certs.empty?
  end

end
