class RemoveImageIdFromContents < ActiveRecord::Migration[6.1]
  def change
    remove_column :contents, :image_id, :string
  end
end
