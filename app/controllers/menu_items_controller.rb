class MenuItemsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:buy]
  before_action :authenticate_user!, except: [:buy]
  before_action :check_roles, except: [:buy]
  before_action :set_item, only: [:show, :update, :edit, :destroy, :buy]
  before_action :set_menus, only: [:show, :update, :edit, :new]
  
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

  def buy
    p @item
    Stripe.api_key = ENV['STRIPE_API_KEY']
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      mode: 'payment',
      success_url: success_url(params[:id]),
      cancel_url: cancel_url(params[:id]),
      line_items: [
        {
          price_data: {
            currency: 'aud',
            product_data: {
              name: @item.item
            },
            unit_amount: (@item.price.to_f * 100).to_i
          },
          quantity: 1
        }
      ]
    })

    render json: session
  end

  def success
    render plain: "Success!"
  end

  def cancel
    render plain: "The transaction was cancelled!"
  end

  private

  def set_menus
    @menus = Menu.all
  end

  def set_item
    @item = MenuItem.find(params[:id])
  end

  def check_roles
    if !(user_signed_in? && current_user.has_role?(:admin))
      flash[:alert] = "You are not authorized to access that page"
      redirect_to root_path
    end
  end

  def menu_item_params
    params.require(:menu_item).permit(:item, :price, :quantity, :image, menu_ids: [])
  end
end
