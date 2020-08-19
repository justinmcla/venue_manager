class CreateShiftHours < ActiveRecord::Migration[6.0]
  def change
    create_table :shift_hours do |t|
      t.integer :booking_id
      t.integer :employee_id
    end
  end
end
