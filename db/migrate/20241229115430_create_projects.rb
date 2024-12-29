class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :description
      t.string :public_id, null: false
      t.string :user_private_id, null: false

      t.timestamps
    end

    add_index :projects, :public_id, unique: true
    add_index :projects, :user_private_id
  end
end
