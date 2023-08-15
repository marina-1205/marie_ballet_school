class CartItem < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item
  
  # 税込価格から数量を計算して小計をだすメソッド
  def subtotal
    item.price * quantity
  end

end