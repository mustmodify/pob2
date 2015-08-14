class MoreFieldsForEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :email, :string, :after => :dob
    add_column :employees, :ident_issuer, :string, :after => :zipcode
    add_column :employees, :ident_number, :string, :after => :ident_issuer
    add_column :employees, :ident_issue_date, :date, :after => :ident_number
    add_column :employees, :ident_expiration_date, :date, :after => :ident_issue_date
  end
end
