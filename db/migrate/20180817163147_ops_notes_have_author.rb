class OpsNotesHaveAuthor < ActiveRecord::Migration
  def change
    add_column :ops_notes, :author_id, :integer, after: :body
  end
end
