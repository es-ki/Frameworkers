class CreateSwots < ActiveRecord::Migration[8.0]
  def change
    create_table :swots do |t|
      t.string :public_id, null: false, default: -> { "UUID()" }
      t.string :strength
      t.string :weakness
      t.string :opportunity
      t.string :threat
      t.text :analysis

      t.timestamps
    end

    add_index :swots, :public_id, unique: true
  end
end
