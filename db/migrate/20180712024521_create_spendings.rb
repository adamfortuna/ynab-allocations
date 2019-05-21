class CreateSpendings < ActiveRecord::Migration[5.2]
  def change
    create_table :spendings do |t|
      t.integer :category_id
      t.integer :user_id
      t.date :month
      t.integer :budgeted
      t.integer :activity
      t.integer :balance
    end
  end
end
