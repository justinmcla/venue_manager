class Item < ActiveRecord::Base
    belongs_to :inventory
    validates :name, :quantity, presence: true
end