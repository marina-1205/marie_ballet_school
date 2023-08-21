class Admin::ReservesController < ApplicationController
  def index
    @reserves = Reserve.all
  end

  def show
    @reserve = Reserve.find(params[:id])
  end
  
  def create
    @reserve = Reserve.new(reserve_params)
    if @reserve.save
      redirect_to admin_reserves_path(@reserve.id)
    else
      @reserves = Reserve.all
      render :index
    end
  end
end
