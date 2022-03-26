# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
   @customer = Customer.find_by(email: params[:customer][:email])
    if @customer.nil?
     redirect_to new_customer_registration_path
    else
     if @customer.valid_password?(params[:customer][:password]) && (@customer.is_active == "有効")
      sign_in @customer
      redirect_to root_path
     else
      flash[:notice] = "退会済です。"
      redirect_to new_customer_session_path
     end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

end
