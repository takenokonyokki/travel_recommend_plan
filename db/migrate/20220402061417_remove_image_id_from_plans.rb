class RemoveImageIdFromPlans < ActiveRecord::Migration[6.1]
  def change
    remove_column :plans, :image_id, :string
  end
end
