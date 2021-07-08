class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    # page
  end
end
