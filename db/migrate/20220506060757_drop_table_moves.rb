class DropTableMoves < ActiveRecord::Migration[6.1]
  def change
    drop_table :moves do |t|
      t.string :name
    end
  end
end
