class Admin::HomesController < ApplicationController
  skip_before_action :authenticate_customer!

  def top
    if params[:id]
      @customer = Customer.find(params[:id])
      @orders = Order.where(customer_id: @customer.id).order(id: "DESC").page(params[:page]).per(10)
    else
      @orders = Order.all.order(id: "DESC").page(params[:page]).per(10)
    end
  end
end
