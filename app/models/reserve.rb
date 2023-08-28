class Reserve < ApplicationRecord
   belongs_to :lesson_class
   
    enum reservation_status: { waiting_for_reservation: true, completion_of_reservation: false }
   
   validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_kana_name, presence: true
  validates :first_kana_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :age, presence: true
  validates :reservation_date, presence: true
  
end
