class Position < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :employees, :join_table => :competencies
  has_many :competencies
  has_many :customary_certs
  has_many :cert_names, :through => :customary_certs
  has_many :assignments

  scope :alphabetical, -> {order(:name)}

  def removable?
    employees.empty? && competencies.empty?
  end

  def color
    c = read_attribute(:color)
    if c.nil?
      nil
    elsif c.to_s[0] == '#'
      c
    elsif c.length == 6
      "##{c}"
    end
  end

  def to_s
    name
  end
end
