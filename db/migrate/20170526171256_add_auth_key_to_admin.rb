class AddAuthKeyToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :auth_key, :string
  end
end
