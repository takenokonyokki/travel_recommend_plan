class AddReservationToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :reservation, :string
  end
end
