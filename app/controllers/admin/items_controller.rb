class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all.page(params[:page]).per(10)
    @genre = Genre.all
  end

  def new
    @item = Item.new
  end

  def create
    @item =Item.new(item_params)
    tags = Vision.get_image_data(item_params[:image])
    if @item.save!
       tags.each do |tag|
        @item.tags.create(name: tag)
      end
      redirect_to admin_item_path(@item), notice: "商品が登録されました☺︎"
    else
      render :new, notice: "商品の登録︎が失敗しました"
    end
  end

  def show
    @item = Item.find(params[:id])
    @genre = Genre.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update!(item_params)
        redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  def search
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_available)
  end

end