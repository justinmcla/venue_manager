class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :customer
      t.date :date
      t.time :time
      t.integer :venue_id
    end
  end
end
