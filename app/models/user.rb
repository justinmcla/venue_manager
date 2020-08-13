class User < ActiveRecord::Base
    has_many :venues
    has_many :bookings, through: :venues
    has_many :tenants, through: :bookings
end
