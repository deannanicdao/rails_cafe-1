class MenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_roles
  before_action :set_item, only: [:show, :update, :edit, :destroy]

  def index
    @items = MenuItem.order(:item)
  end

  def show
  end

  def create
    item = MenuItem.create(menu_item_params)
    redirect_to menu_item_path(item)
  end

  def new
    @item = MenuItem.new
  end

  def update
    @item.update(menu_item_params)
    redirect_to menu_item_path(@item)
  end

  def edit
  end

  def destroy
    @item.destroy
    redirect_to menu_items_path
  end

  private

  def set_item
    @menus = Menu.all
    @item = MenuItem.find(params[:id])
  end

  def check_roles
    if !(user_signed_in? && current_user.has_role?(:admin))
      flash[:alert] = "You are not authorized to access that page"
      redirect_to root_path
    end
  end

  def menu_item_params
    params.require(:menu_item).permit(:item, :price, :quantity, menu_ids: [])
  end
end
