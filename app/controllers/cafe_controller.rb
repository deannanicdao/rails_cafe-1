class CafeController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_menu

  def index
  end

  def order
    render plain: @menu[params[:id].to_sym]
  end

  def set_menu
    puts "set_menu run"
    @menu = {
      latte: 4.00,
      scone: 5.00,
      tea: 3.00,
      donut: 2.50,
    }
  end
end
