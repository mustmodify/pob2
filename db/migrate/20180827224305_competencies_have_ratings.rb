class CompetenciesHaveRatings < ActiveRecord::Migration
  def change
    add_column :competencies, :rating, :string, limit: 4, after: :rate
  end
end
