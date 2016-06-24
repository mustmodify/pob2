class CompetencyRateCanBeADecimal < ActiveRecord::Migration
  def change
    change_column :assignments, :rate, :decimal, :precision => 10, :scale => 2
    change_column :competencies, :rate, :decimal, :precision => 10, :scale => 2
    change_column :jobs, :rate, :decimal, :precision => 10, :scale => 2
  end
end
