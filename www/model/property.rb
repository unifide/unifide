class Property < ActiveRecord::Base

    belongs_to :unit
    belongs_to :property_type
end
