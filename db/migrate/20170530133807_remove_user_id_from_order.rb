class RemoveUserIdFromOrder < ActiveRecord::Migration
  def up
    remove_column :orders, :user_id
  end

  def down
    add_column :orders, :user_id, :int
  end
end
