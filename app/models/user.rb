class User < ActiveRecord::Base
    has_secure_password
    has_many :venues
    has_many :tenants
    has_many :bookings, through: :venues
    has_many :inventories, through: :venues
end
