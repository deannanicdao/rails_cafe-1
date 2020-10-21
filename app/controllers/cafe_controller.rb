class CafeController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_menu

  def index
  end

  def order
    render plain: @menu[params[:id].to_sym]
  end

  def set_menu
    @menu = MenuItem.all
  end
end
