class AddLatitudeToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :latitude, :float
    add_column :contents, :longitude, :float
  end
end
