class Inventory < ActiveRecord::Base
    belongs_to :venue
    has_many :items
end
