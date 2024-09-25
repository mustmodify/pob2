class CreateClients < ActiveRecord::Migration
  def change
     create_table :clients do |t|
       t.boolean :active
       t.string :name
     end

     Q.tell %|INSERT INTO clients (name)
 SELECT DISTINCT client
 FROM projects
 WHERE client IS NOT NULL;
 |
  add_column :projects, :client_id, :integer

  Q.tell %|UPDATE projects, clients
 SET projects.client_id = clients.id
 WHERE projects.client = clients.name;
 |
  end
end
