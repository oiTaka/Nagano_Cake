class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  enum method_of_payment: { クレジットカード: 1, 銀行振込: 2 }
end
