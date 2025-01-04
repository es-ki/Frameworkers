class AddUuidToProjects < ActiveRecord::Migration[8.0]
  def up
    change_column :projects, :public_id, :string, default: -> { "uuid()" }, null: false

    unless index_exists?(:projects, :public_id, unique: true)
      add_index :projects, :public_id, unique: true
    end
  end

  def down
    remove_index :projects, :public_id
    change_column :projects, :public_id, :string, null: false
  end
end
