class Public::ItemsController < ApplicationController
  def index
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @items_all = Item.where(genre_id: @genre.id, is_active: true)
    @items = @items_all.page(params[:page]).per(8)
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
