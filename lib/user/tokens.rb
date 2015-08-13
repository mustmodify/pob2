module User::Tokens
  def set_tokens
    self.perishable_token = String.random(20) if self.perishable_token.blank?
    self.persistence_token = String.random(20) if self.persistence_token.blank?
  end

  def self.find_by_perishable_token( token )
    User.where(perishable_token: token).first.tap do |user|
      user.reset_perishable_token!
    end
  end

  def reset_perishable_token!
    update_attribute(:perishable_token, String.random(20))
  end
end
