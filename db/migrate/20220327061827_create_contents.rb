class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.integer :plan_id
      t.integer :order_id
      t.integer :day
      t.integer :time
      t.string :place
      t.string :image_id
      t.text :explanation
      t.string :name
      t.string :address
      t.integer :telephonenumber
      t.string :access
      t.string :businesshours
      t.string :price
      t.string :stay_time
      t.float :rate
      t.integer :move_id
      t.integer :move_time

      t.timestamps
    end
  end
end
