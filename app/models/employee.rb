class Employee < ActiveRecord::Base
    belongs_to :user
    has_many :shift_hours
    has_many :bookings, through: :shift_hours
    validates :first_name, :last_name, :start_date, presence: true
end
