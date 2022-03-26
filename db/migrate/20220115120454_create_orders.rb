class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :postage, default: 600
      t.integer :method_of_payment
      t.string :total_payment
      t.string :name
      t.string :address
      t.string :zip_code
      t.integer :order_status
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
