class AddUuidToSwots < ActiveRecord::Migration[8.0]
  def change
    change_column :swots, :public_id, :string, default: -> { "uuid()" }, null: false
  end
end
