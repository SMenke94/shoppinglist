class ChangeRoleOfUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :admin, :role
    change_column :users, :role, :integer
  end
end
