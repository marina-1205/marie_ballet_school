class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :item

  #製作ステータス
  enum make_status: { unable_to_start: 0, waiting_for_production: 1, in_production: 2, completion_of_production: 3 }

  # 税込価格から数量を計算して小計をだすメソッド
  def subtotal
    (item.price * quantity.to_i).to_i
  end

end