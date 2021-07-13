class Public::ItemsController < ApplicationController
  def index
    if params[:id]
      @genre = Genre.find(params[:id])
      @items_all = Item.where(genre_id: @genre.id, is_active: true)
      @items = @items_all.page(params[:page]).per(8)
      @genres = Genre.all
    else
      @items_all = Item.where(is_active: true)
      @items = @items_all.page(params[:page]).per(8)
      @genres = Genre.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end
