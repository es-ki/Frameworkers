class AddProjectIdToSwots < ActiveRecord::Migration[8.0]
  def change
    add_reference :swots, :project, null: false, foreign_key: true
  end
end
