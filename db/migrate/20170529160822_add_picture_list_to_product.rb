class AddPictureListToProduct < ActiveRecord::Migration
  def change
    add_column :products, :picture_list, :string
  end
end
