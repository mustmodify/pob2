class AllowLongerPhoneNumbers < ActiveRecord::Migration
  def change
    change_column :projects, :phone, :string, :length => 250
  end
end
