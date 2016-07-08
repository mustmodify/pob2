class AssignmentsHavePoNumbers < ActiveRecord::Migration
  def change
    add_column :assignments, :po_number, :string
    add_column :assignments, :created_at, :datetime
    add_column :assignments, :updated_at, :datetime
  end
end
