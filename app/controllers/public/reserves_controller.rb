class Public::ReservesController < ApplicationController
  def new
    @reserve = Reserve.new
  end

  def complete
  end
end
