class ChangeDatatypeDayOfContents < ActiveRecord::Migration[6.1]
  def change
    change_column :contents, :day, :string
  end
end
