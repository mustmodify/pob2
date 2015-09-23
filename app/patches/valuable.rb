require 'valuable'

class Valuable
  def ==(other)
    self.attributes == other.attributes && self.class == other.class
  end
end
