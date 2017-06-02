class AddDescriptionToProduct < ActiveRecord::Migration
  def change
    add_column :products, :desc, :string
  end
end
