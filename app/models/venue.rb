class Venue < ActiveRecord::Base
    belongs_to :user
    has_many :bookings
    has_many :inventories
    has_many :items, through: :inventories
end
