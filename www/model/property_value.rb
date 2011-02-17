class PropertyValue < ActiveRecord::Base

    belongs_to :property_type
    has_many :unit_properties

end
