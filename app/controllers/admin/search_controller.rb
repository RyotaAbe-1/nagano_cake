class Admin::SearchController < ApplicationController
  skip_before_action :authenticate_customer!
  def search
    if params[:category] == "1"
      @items = Item.all.search(params[:keyword]).page(params[:page]).per(10)
      render "admin/items/index"
    elsif params[:category] == "2"
      @customers = Customer.all.search(params[:keyword]).page(params[:page]).per(10)
      render "admin/customers/index"
    elsif params[:category] == "3"
      @orders = Order.all.search(params[:keyword]).order(id: "DESC").page(params[:page]).per(10)
      render "admin/homes/top"
    end
  end
end
