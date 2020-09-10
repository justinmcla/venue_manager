class Tenant < ActiveRecord::Base
    has_many :bookings
    belongs_to :user
    validates :org_name, :poc_name, presence: true
end
