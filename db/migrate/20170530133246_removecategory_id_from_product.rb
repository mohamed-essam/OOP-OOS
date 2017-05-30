class RemovecategoryIdFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :category_id
  end

  def down
    add_column :products, :category_id, :int
  end
end
