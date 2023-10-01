class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :shopping_addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  def full_name
    "#{last_name} #{first_name}"
  end

  def full_name_kana
    "#{last_name_kana} #{first_name_kana}"
  end

  # is_deletedがfalseならtrueを返し、ログイン時に
  #退会済みのユーザーが同じアカウントでログイン出来ない設定
  def active_for_authentication?
    super && (is_deleted == false)
  end

  validates :last_name, presence: true
  validates :first_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "フリガナ（名前）はカタカナのみである必要があります" }
  validates :last_kana_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "フリガナ（苗字）はカタカナのみである必要があります" }
  validates :first_kana_name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "メールアドレスは半角文字のみである必要があります" }
  validates :address, presence: true
  validates :postcode, presence: true, format: { with: /\A\d+\z/, message: "郵便番号は数字のみである必要があります" }
  validates :school_name, presence: true
  validates :post_name, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d+\z/, message: "電話番号は数字のみである必要があります" }
end