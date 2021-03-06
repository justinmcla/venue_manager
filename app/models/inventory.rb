class Inventory < ActiveRecord::Base
    belongs_to :venue
    has_many :items, dependent: :destroy
    validates :name, presence: true
end
