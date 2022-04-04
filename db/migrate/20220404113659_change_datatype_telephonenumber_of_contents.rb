class ChangeDatatypeTelephonenumberOfContents < ActiveRecord::Migration[6.1]
  def change
    change_column :contents, :telephonenumber, :string
  end
end
