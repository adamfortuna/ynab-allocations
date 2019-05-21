class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :ynab_id
      t.string :name
      t.integer :category_group_id
    end
  end
end
