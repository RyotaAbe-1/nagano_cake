class Public::OrdersController < ApplicationController
  skip_before_action :authenticate_admin!

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
      @order.customer_id = current_customer.id
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.shipping_fee = 800
      @order.total_payment = array_total.sum + @order.shipping_fee
    elsif params[:info] == "2"
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      address = Address.find(params[:select_info])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
      @order.shipping_fee = 800
      @order.total_payment = array_total.sum + @order.shipping_fee
    elsif params[:info] == "3"
      @order = Order.new(order_params)
      unless @order.postal_code.empty? && @order.address.empty? && @order.name.empty?
        @order.customer_id = current_customer.id
        @order.shipping_fee = 800
        @order.total_payment = array_total.sum + @order.shipping_fee
        address = Address.new
        address.customer_id = current_customer.id
        address.name = @order.name
        address.postal_code = @order.postal_code
        address.address = @order.address
        address.save
      else
        @addresses = Address.where(customer_id: current_customer.id)
        render :new
      end

    end
  end

  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.shipping_fee = 800
    cart_items = CartItem.where(customer_id: current_customer.id)
    array_total = []
    cart_items.each do |cart_item|
      array_total.push(cart_item.include_tax(1.1).floor * cart_item.amount)
    end
    order.total_payment = array_total.sum + order.shipping_fee
    order.save

    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = order.id
      order_detail.item_id = cart_item.item_id
      order_detail.price = cart_item.include_tax(1.1).floor
      order_detail.amount = cart_item.amount
      order_detail.save
    end
    cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def thanks
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(id: "DESC").page(params[:page]).per(6)
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end
end
