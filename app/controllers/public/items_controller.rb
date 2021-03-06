class Public::ItemsController < ApplicationController
  skip_before_action :authenticate_admin!

  def index
    if params[:id]
      @genre = Genre.find(params[:id])
      @items_all = Item.where(genre_id: @genre.id, is_active: true)
      @items = @items_all.page(params[:page]).per(8)
      @genres = Genre.all
    elsif params[:keyword]
      @search = params[:keyword]
      @items_all = Item.where(is_active: true).search(params[:keyword])
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
