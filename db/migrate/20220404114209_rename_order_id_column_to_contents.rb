class RenameOrderIdColumnToContents < ActiveRecord::Migration[6.1]
  def change
    rename_column :contents, :order_id, :order
  end
end
