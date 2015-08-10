class Array
  def random
    self[ rand(self.size) ]
  end
end

class ActiveRecord::Base
  def self.random
    self.order('RAND()').first
  end
end

