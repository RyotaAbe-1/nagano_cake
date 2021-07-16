class Admin::OrdersController < ApplicationController
  skip_before_action :authenticate_customer!

  def show
    @order = Order.find(params[:id])
  end
end
