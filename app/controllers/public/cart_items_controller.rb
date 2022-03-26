class Public::CartItemsController < ApplicationController
    before_action :authenticate_customer!

  def index
   @cart_items = current_customer.cart_items
   @sum = 0
   @cart_items.each do |cart_item|
     @sum = @sum+cart_item.item.add_tax_price*cart_item.amount
   end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
     cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
     cart_item.update(amount: params[:cart_item][:amount].to_i + cart_item.amount)
     flash[:notice] = "数量変更しました"
     redirect_to cart_items_path
    else
     @cart_item.save
     redirect_to cart_items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
		@cart_item.update(cart_item_params)
		flash[:notice] = "数量変更しました"
		redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end