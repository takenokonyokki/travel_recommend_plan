class ChangeDatatypeTimeOfContents < ActiveRecord::Migration[6.1]
  def change
    change_column :contents, :time, :string
  end
end
