class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    array_total = []
    @cart_items.each do |cart_item|
      array_total.push(cart_item.include_tax(1.1).floor * cart_item.amount)
    end

    if params[:info] == "1"
      @order = Order.new(order_params)
      @order.id = current_customer.id

      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

      @order.shipping_fee = 800
      @order.total_payment = array_total.sum + @order.shipping_fee

    elsif params[:info] == "2"
      @order.total_payment = array_total.sum + @order.shipping_fee
    elsif params[:info] == "3"
      @order = Order.new(order_params)
      @order.id = current_customer.id
      @order.shipping_fee = 800

      @order.total_payment = array_total.sum + @order.shipping_fee
    end
  end


  def create
    order = Order.new(order_params)
    order.id = current_customer.id
    order.shipping_fee = 800
    cart_items = CartItem.where(customer_id: current_customer.id)
    array_total = []
    cart_items.each do |cart_item|
      array_total.push(cart_item.include_tax(1.1).floor * cart_item.amount)
    end
    order.total_payment = array_total.sum + order.shipping_fee
    order.save
    redirect_to orders_thanks_path

  end
  
  def thanks
  end
  

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end
end
