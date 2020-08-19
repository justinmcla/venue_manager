class Booking < ActiveRecord::Base
    belongs_to :venue
    belongs_to :user
    belongs_to :tenant
    has_many :shift_hours
    has_many :employees, through: :shift_hours
end
