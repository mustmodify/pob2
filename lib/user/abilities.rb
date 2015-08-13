module User::Abilities
  def can_read?(obj)
    true
  end

  def can_update?(obj)
    true
  end
end
