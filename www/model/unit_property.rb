class UnitProperty < ActiveRecord::Base

    belongs_to :unit
    belongs_to :property_type
    belongs_to :property_value
end
