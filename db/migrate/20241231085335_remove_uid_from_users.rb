class RemoveUidFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :uid, :string
  end
end
