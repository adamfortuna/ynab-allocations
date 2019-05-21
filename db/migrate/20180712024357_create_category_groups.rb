class CreateCategoryGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :category_groups do |t|
      t.integer :budget_id
      t.string :ynab_id
      t.string :name
    end
  end
end
