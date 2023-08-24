class Admin::ReservesController < ApplicationController
  def index
    @reserves = Reserve.all.page(params[:page])
    @lesson_class = LessonClass.all
  end

  def show
    @reserves = Reserve.all
    @reserve = Reserve.find(params[:id])
    @lesson_class = LessonClass.all
  end
  
  # def create
  #   @reserve = Reserve.new(reserve_params)
  #   if @reserve.save
  #     redirect_to admin_reserves_path(@reserve.id)
  #   else
  #     @reserves = Reserve.all
  #     render :index
  #   end
  # end
  
  def update
     @reserve = Reserve.find(params[:id])
     @reserve.update!(reserve_params)
     pp @reserve
     redirect_to request.referer
  end
  
  private

  # ストロングパラメーターの定義
  def reserve_params
    params.require(:reserve).permit(:reservation_status) 
  
  end
end