class DropShoppingListsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :shopping_lists
  end
end
