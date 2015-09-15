# -*- coding: utf-8 -*-

class String
  def self.random(length)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    random_string = ""
    1.upto(length) { |i| random_string << chars[rand(chars.size-1)] }
    return random_string
  end

  def to_key
    self.tableize.gsub(/[^\w]/, '_').gsub(/__*/, '_')
  end

  def sanitize
    ActiveRecord::Base::sanitize(self)
  end
end

