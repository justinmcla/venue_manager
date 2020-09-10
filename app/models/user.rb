class User < ActiveRecord::Base
    has_secure_password
    has_many :employees, dependent: :destroy
    has_many :tenants, dependent: :destroy
    has_many :venues, dependent: :destroy
    has_many :tasks, dependent: :destroy
    has_many :bookings, through: :venues
    has_many :inventories, through: :venues
    validates :first_name, :last_name, :username, presence: true
    validates :username, uniqueness: true
end
