class Projects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :image, :string, null: false
  end
end
