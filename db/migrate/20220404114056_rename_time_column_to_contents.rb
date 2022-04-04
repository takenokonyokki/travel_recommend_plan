class RenameTimeColumnToContents < ActiveRecord::Migration[6.1]
  def change
    rename_column :contents, :time, :minute
  end
end
