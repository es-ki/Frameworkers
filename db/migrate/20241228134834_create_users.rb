class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: false do |t|
      t.string :uuid, limit: 36, default: -> { 'UUID()' }, null: false, primary_key: true
      t.string :name, limit: 30, null: false

      t.timestamps
    end
  end
end
