class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_item
  has_many :tags, dependent: :destroy
  belongs_to :genre

  # カート内の数量を取得するメソッド
  def cart_item_quantity(customer)
    cart_item = customer.cart_items.find_by(item_id: self.id)
    cart_item ? cart_item.quantity : 0
  end

  has_one_attached :image

  def get_item_image
    #すり抜け防止
    (image.attached?) ? image : 'brownie.jpg'
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  with_options presence: true do
    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  end

end