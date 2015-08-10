module Q
  def ask(sql)
    ActiveRecord::Base.connection.select_all( sql )
  end

  def value( sql )
    ActiveRecord::Base.connection.select_value( sql )
  end

  def tell(sql)
    ActiveRecord::Base.connection.execute( sql )
  end

  alias_method :instruct, :tell
  extend self
end

