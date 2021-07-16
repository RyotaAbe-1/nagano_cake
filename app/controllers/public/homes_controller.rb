class Public::HomesController < ApplicationController
  skip_before_action :authenticate_admin!
  
  def top
    @items = Item.all.order(id: "DESC").limit(4)
    @genres = Genre.all
  end
  
  def about
  end
end
