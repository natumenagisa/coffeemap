class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_params
    else
      render "edit"
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: true)
    reset_session
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :email, :is_active)
  end
end
