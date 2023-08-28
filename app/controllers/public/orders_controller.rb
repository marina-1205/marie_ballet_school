class Public::OrdersController < ApplicationController
  
  before_action :authenticate_customer!

  # 注文情報入力画面を表示するアクション
  def new
    cart_items = current_customer.cart_items
    if cart_items.present?
      # カートが空でない場合、新しい注文オブジェクトを生成
      @order = Order.new
    else
      # カートが空の場合、エラーメッセージを表示して前のページにリダイレクト
      flash[:notice] = "カートに商品が入っていません。"
      redirect_to request.referer
    end
  end

  # 注文情報確認画面を表示するアクション
  def confirm
    #注文情報入力されたデータが入って本当に存在するかどうか判断
    if params[:order]
      #データが入る空の変数作成
      @order = Order.new(order_params)
      #ログインしているcustomerデータが入る
      @order.customer_id = current_customer.id
      #ログインしているcart_itemsデータが入る
      @cart_items = current_customer.cart_items
      #カート内商品の合計金額を算出して入れる
      @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
      #送料を入れる
      @order.postage = 800
      #合計金額と送料を+して請求金額を算出して入れる
      @order.total_amount = @total_amount + @order.postage.to_i
    end
  end

  # 注文を作成するアクション
  def create
    @order = Order.new(order_params)
    #ログインしているユーザーのcustomerデータを変数に入れる
    @order.customer_id = current_customer.id
    #ログインしているユーザーのあcart_itemsデータを変数に入れる
    @cart_items = current_customer.cart_items
    #カート内商品を受け取って合計金額を算出
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }

    if @order.save
      # 注文が保存された場合、注文商品情報も保存する
      current_customer.cart_items.each do |cart_item|
        @order_item = OrderItem.new
        #cart_itemデータの中にあるitem_idを取り出して変数に格納
        @order_item.item_id = cart_item.item_id
        #注文確定されたデータを格納
        @order_item.order_id = @order.id
        # カートアイテムから価格情報を取得
        cart_item = current_customer.cart_items.first
        # @order_item の価格に設定
        @order_item.price = cart_item.item.price
        #注文確定された数量データを格納
        @order_item.quantity = cart_item.quantity
        @order_item.save!
      end
      # 注文が完了したらカートを空にして、注文完了画面にリダイレクトする
      current_customer.cart_items.destroy_all
      redirect_to completed_orders_path
    else
      # 注文情報が不正な場合、エラーメッセージを表示して注文情報入力画面を再表示
      flash[:notice] = "住所は必須です"
      @order = Order.new(order_params)
      render 'new'
    end
  end

  # 注文完了画面を表示するアクション
  def completed
  end

  # 注文履歴一覧を表示するアクション
  def index
    @orders = current_customer.orders
  end

  # 注文詳細画面を表示するアクション
  def show
    @order = Order.find(params[:id])
    @customer = current_customer
    @orders = current_customer.orders
  end
  
  def get_confirm
    redirect_to cart_items_path
  end
  
  private

  def order_params
    params.require(:order).permit(:customer_id, :postage, :total_amount, :status, :payment_method, :name, :postcode, :address)
  end
  
end