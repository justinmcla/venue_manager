class Tenant < ActiveRecord::Base
    has_many :bookings
end
