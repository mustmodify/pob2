class CompetenciesHaveRates < ActiveRecord::Migration
  def change
    add_column :competencies, :rate, :decimal, :after => :position_id
  end
end
