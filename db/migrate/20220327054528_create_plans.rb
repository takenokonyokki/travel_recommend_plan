class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.string :title
      t.string :travel
      t.string :image_id

      t.timestamps
    end
  end
end
