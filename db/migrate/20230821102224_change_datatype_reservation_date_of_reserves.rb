class ChangeDatatypeReservationDateOfReserves < ActiveRecord::Migration[6.1]
  def change
    change_column :reserves, :reservation_date, :datetime
  end
end
