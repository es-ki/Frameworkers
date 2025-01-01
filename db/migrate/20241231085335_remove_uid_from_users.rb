class RemoveUidFromUsers < ActiveRecord::Migration[8.0]
  def change
    if column_exists?(:users, :uid)
      remove_column :users, :uid, :string
    end
  end
end
