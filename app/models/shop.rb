class Shop < ApplicationRecord
  has_many :products

  def shop
    self
  end
end
