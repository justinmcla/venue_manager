class Employee < ActiveRecord::Base
    belongs_to :user
    has_many :shift_hours
    has_many :bookings, through: :shift_hours
end
