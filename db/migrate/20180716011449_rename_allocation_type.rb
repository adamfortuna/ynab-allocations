class RenameAllocationType < ActiveRecord::Migration[5.2]
  def change
    rename_column :allocations, :type, :allocate_from
  end
end
