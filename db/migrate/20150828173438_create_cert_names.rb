class CreateCertNames < ActiveRecord::Migration
  def change
    create_table :cert_names do |t|
      t.string :name
    end

    add_column :certs, :cert_name_id, :integer, :after => :description
    remove_column :certs, :description, :string 
  end
end
