class User < ActiveRecord::Base
    has_many :venues
    has_many :bookings, through :venues
end
