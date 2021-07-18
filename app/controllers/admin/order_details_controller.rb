class Admin::OrderDetailsController < ApplicationController
  skip_before_action :authenticate_customer!

  def update
    order_detail = OrderDetail.find(params[:id])
    order = Order.find_by(id: params[:order_id])
    order_detail.update(order_detail_params)
    if order_detail.product_status == "制作中"
      order.update(order_status: "制作中")
    end
    array_status = []
    order.order_details.each do |order_detail|
      array_status.push(order_detail.product_status)
    end
    if array_status.all?{|n| n == "制作完了"}
      order.update(order_status: "発送準備中")
    end
    redirect_to admin_order_path(order.id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:product_status)
  end
end
