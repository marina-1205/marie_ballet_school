class Admin::OrdersController < ApplicationController

  # 注文詳細を表示するアクション
  def show
    @orders = Order.all
    @order = Order.find(params[:id]) # パラメーターで指定された注文の詳細情報を取得
    @order_items = @order.order_items # 注文に紐づく注文商品の一覧を取得
  end

  # 注文のステータスを更新するアクション
  def update
    @order = Order.find(params[:id]) # パラメーターで指定された注文の情報を取得
    @order_items = @order.order_items # 注文に紐づく注文商品の一覧を取得
    # 注文のステータスを更新
    if @order.update(order_params)
      # もし注文のステータスが入金確認であれば、紐づく注文商品の制作ステータスを制作待ちに更新
      @order_items.update_all(make_status: "waiting_for_production") if @order.status == "confirmation_of_payment"
    end
    redirect_to request.referer # 前のページにリダイレクトする
  end

  def index
    @orders = Order.page(params[:page]).reverse_order.per(10)
  end

  private

  # ストロングパラメーターの定義
  def order_params
    params.require(:order).permit(:status) # 注文のステータスを更新する際に許可するパラメーターを指定
  end

end