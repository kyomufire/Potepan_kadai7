class AddNumberOfGuestsToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :number_of_guests, :integer
  end
end
