class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end
  
  def edit
    
  end
  
  def update
  end

  def confirm
    @customer = Customer.find(current_customer.id)
  end

  def withdraw
    customer = Customer.find(current_customer.id)
    customer.update(customer_params)
    redirect_to root_path
  end
  
  def customer_params
    params.require(:customer).permit(:is_active)
  end
end
