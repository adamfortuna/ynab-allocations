class CreateBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :budgets do |t|
      t.integer :user_id
      t.string :ynab_id
      t.string :name
      t.string :currency
      t.integer :currency_decimals
      t.string :currency_symbol
    end
  end
end
