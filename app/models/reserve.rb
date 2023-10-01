class Reserve < ApplicationRecord
   belongs_to :lesson_class
   
    enum reservation_status: { waiting_for_reservation: true, completion_of_reservation: false }
   
   validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_kana_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "フリガナ（苗字）はカタカナのみである必要があります" }
  validates :first_kana_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "フリガナ（名前）はカタカナのみである必要があります" }
  validates :phone_number, presence: true, format: { with: /\A\d+\z/, message: "電話番号は数字のみである必要があります" }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "メールアドレスは半角文字のみである必要があります" }
  validates :age, presence: true
  validates :reservation_date, presence: true
  
end
