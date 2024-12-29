class ModifyUsersTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :users, if_exists: true

    create_table :users do |t|
      t.string :private_id, null: false
      t.string :email, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    add_index :users, :private_id, unique: true
    add_index :users, :email, unique: true
  end
end
