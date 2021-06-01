class ChangeStyleNameColumn < ActiveRecord::Migration[5.2]
  def change
     change_column :tasks, :name, :text, null: false
  end
end
