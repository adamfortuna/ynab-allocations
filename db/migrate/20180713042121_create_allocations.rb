class CreateAllocations < ActiveRecord::Migration[5.2]
  def change
    create_table :allocations do |t|
      t.integer :user_id
      t.string :name
      t.timestamps
    end
  end
end
