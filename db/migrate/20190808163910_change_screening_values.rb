class ChangeScreeningValues < ActiveRecord::Migration
  def up
    Q.tell %|update screenings SET outcome="Pass" where outcome="Negative"|
    Q.tell %|update screenings SET outcome="Fail" where outcome="Positive"|
  end

  def down
    Q.tell %|update screenings SET outcome="Negative" where outcome="Pass"|
    Q.tell %|update screenings SET outcome="Positive" where outcome="Fail"|
  end
end
