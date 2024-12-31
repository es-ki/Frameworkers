class ModifyUsersAndProjects < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :private_id, :string if column_exists?(:users, :private_id)
    remove_column :projects, :user_private_id, :string if column_exists?(:projects, :user_private_id)

    add_column :projects, :user_id, :bigint, null: false
    add_foreign_key :projects, :users, column: :user_id
  end
end
