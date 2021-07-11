class Admin::OrderDetailsController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
end
