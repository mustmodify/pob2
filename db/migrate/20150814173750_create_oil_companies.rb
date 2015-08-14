class CreateOilCompanies < ActiveRecord::Migration
  def change
    create_table :oil_cos do |t|
      t.string :name
    end
  end
end
