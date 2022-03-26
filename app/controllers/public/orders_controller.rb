class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
  	@order = Order.new
  end

  def confirm
  	@order = Order.new(order_params)
  	@order.customer_id = current_customer.id
  	@cart_items = current_customer.cart_items

  	@sum = 0
    @cart_items.each do |cart_item|
      @sum = @sum+cart_item.item.add_tax_price*cart_item.amount
    end

    @order.zip_code = current_customer.postal_code
    @order.address = current_customer.address
  	@order.name = current_customer.last_name + current_customer.first_name
  	@order.total_payment = @order.postage + @sum
  end

  def create
  	@order = Order.new(order_params)
  	@order.save

	  current_customer.cart_items.each do |cart_item|
	   order_detail = OrderDetail.new
	   order_detail.item_id = cart_item.item.id
	   order_detail.order_id = @order.id
	   order_detail.price = cart_item.item.add_tax_price
	   order_detail.order_amount = cart_item.amount
	   order_detail.save
	  end
  	current_customer.cart_items.destroy_all
  	redirect_to orders_complete_path
  end

  def complete
  end

  def index
  	@orders = current_customer.orders.page(params[:page]).per(5)
  end
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

private

  def order_params
	params.require(:order).permit(:customer_id, :method_of_payment, :total_payment, :zip_code, :address, :name, :postage)
  end

end
