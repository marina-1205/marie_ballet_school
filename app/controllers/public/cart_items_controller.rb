class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.includes(:item)
    @total_amount = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
    @cart_item = current_customer.cart_items.new # 新しいCartItemオブジェクトを作成しておく
  end

  # カートに商品を追加
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    # フォームに数量指定しないでカートに追加しようとした場合の処理
    if @cart_item.quantity.nil?
      redirect_to request.referer, notice: '個数を選択してください'
    else
      # 追加しようとした時に同じ商品が存在するかどうかを判断するIF
      existing_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])

      if existing_cart_item
        # カートに商品が存在した場合、数量を更新する
        existing_cart_item.quantity += params[:cart_item][:quantity].to_i
        existing_cart_item.save
        redirect_to cart_items_path, notice: '選択された個数分を追加しました'
      else
        # カート内に商品が存在しない場合、新しくカートに商品を追加する
        if @cart_item.save
          redirect_to cart_items_path, notice: 'カートに商品が追加されました'
        else
          redirect_to request.referer, alert: 'カートに商品を追加できませんでした'
        end
      end
    end
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      # 数量が正しく更新された場合の処理
      redirect_to cart_items_path, notice: '数量を変更しました'
    else
      # 数量の更新が失敗した場合の処理
      redirect_to request.referer, alert: '数量の変更に失敗しました'
    end
  end

  #一つの商品を削除
  def destroy
    current_customer.cart_items.find(params[:id]).destroy
    #遷移前のページのURL取得
    redirect_to request.referer, notice: '該当商品が削除されました'
  end

  #カート内商品を空にする
  def clear
    current_customer.cart_items.destroy_all
    redirect_to request.referer
  end

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :quantity)
  end

end