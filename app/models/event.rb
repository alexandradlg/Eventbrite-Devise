class Event < ApplicationRecord
    belongs_to :creator, class_name: 'User'
    has_and_belongs_to_many :attendees,class_name: 'User'
    
    monetize :price_cents, 
        numericality: {
            greater_than_or_equal_to: 0
        }

end
