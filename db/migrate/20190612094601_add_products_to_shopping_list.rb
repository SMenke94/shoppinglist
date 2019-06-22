class AddProductsToShoppingList < ActiveRecord::Migration[5.2]
  def change
    add_reference :shopping_lists, :product, foreign_key: true
  end
end
