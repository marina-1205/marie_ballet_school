class CartItem < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item
  
  # 税込価格から数量を計算して小計をだすメソッド
  def subtotal
    item.taxin_price * quantity
  end

  #税込価格を計算するメソッドをItemモデルから引き出している
  def taxin_price
    item.taxin_price
  end

end