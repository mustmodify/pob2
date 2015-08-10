class ActiveRecord::Base
  def self.sample(i)
    self.order('RAND()').limit(i)
  end
end

