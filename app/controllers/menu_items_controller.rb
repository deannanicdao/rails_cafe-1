class MenuItemsController < ApplicationController
  def index
    @items = MenuItem.order(:item)
  end

  def show
    @item = MenuItem.find(params[:id])
  end

  def create
    item = MenuItem.create(menu_item_params)
    redirect_to menu_item_path(item)
  end

  def new
  end

  def update
    item = MenuItem.find(params[:id])
    item.update(menu_item_params)
    redirect_to menu_item_path(item)
  end

  def edit
    @item = MenuItem.find(params[:id])
  end

  def destroy
    item = MenuItem.find(params[:id])
    item.destroy
    redirect_to menu_items_path
  end

  private

  def menu_item_params
    params.permit(:item, :price, :quantity)
  end
end
