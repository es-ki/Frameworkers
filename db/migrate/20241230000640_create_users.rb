class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :private_id, null: false
      t.string :email, null: false
      t.timestamps
    end

    add_index :users, :private_id, unique: true
  end
end
