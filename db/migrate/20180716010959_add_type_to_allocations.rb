class AddTypeToAllocations < ActiveRecord::Migration[5.2]
  def change
    add_column :allocations, :type, :string
  end
end
