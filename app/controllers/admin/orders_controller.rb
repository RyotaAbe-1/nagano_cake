class Admin::OrdersController < ApplicationController
  skip_before_action :authenticate_customer!

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order_details = OrderDetail.where(order_id: order.id)
    order.update(order_params)
    if order.order_status == "入金確認"
      order_details.each do |order_detail|
        order_detail.update(product_status: "制作待ち")
      end
    end

    redirect_to admin_order_path(order)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
