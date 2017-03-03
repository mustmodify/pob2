class CreateCustomaryCertifications < ActiveRecord::Migration
  def change
    create_table :customary_certs do |t|
      t.integer :position_id
      t.integer :cert_name_id
      t.timestamps
    end
  end
end
