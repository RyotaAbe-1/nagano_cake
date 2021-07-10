class Admin::CustomersController < ApplicationController
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
end
