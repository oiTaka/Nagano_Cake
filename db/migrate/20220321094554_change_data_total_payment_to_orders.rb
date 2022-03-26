class ChangeDataTotalPaymentToOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :total_payment, :integer
  end
end
