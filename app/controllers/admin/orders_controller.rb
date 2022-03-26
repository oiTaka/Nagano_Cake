class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
   @order = Order.find(params[:id])
   @order_details = @order.order_details
   @sum = 0
   @order_details.each do |order_detail|
     @sum = @sum+order_detail.price*order_detail.order_amount
   end
  end
end
