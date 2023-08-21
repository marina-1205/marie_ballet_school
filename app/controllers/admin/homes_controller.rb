class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
     @orders = Order.order(created_at: :desc).limit(6)
     @reserves = Reserve.order(created_at: :desc).limit(6)
  end

end