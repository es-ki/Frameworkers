class AddUidToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :uid, :string, null: false
    add_index :users, :uid, unique: true
  end
end
