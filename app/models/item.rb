class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  attachment :image
  def add_tax_price
    (self.price * 1.10).round
  end
end
