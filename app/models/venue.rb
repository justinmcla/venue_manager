class Venue < ActiveRecord::Base
    belongs_to :user
    has_many :bookings, dependent: :destroy
    has_many :inventories, dependent: :destroy
    has_many :items, through: :inventories
    validates :name, :seats, :greenrooms, :dressing_rooms, presence: true
end
