class RemoveIconFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :icon, :string
  end
end
