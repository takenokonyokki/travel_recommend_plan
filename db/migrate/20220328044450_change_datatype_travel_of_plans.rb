class ChangeDatatypeTravelOfPlans < ActiveRecord::Migration[6.1]
  def change
    change_column :plans, :travel, :integer
  end
end
