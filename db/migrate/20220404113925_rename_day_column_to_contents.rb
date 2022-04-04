class RenameDayColumnToContents < ActiveRecord::Migration[6.1]
  def change
    rename_column :contents, :day, :hour
  end
end
