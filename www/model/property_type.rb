class PropertyType < ActiveRecord::Base

    has_many :unit_properties
    has_many :property_values
    has_and_belongs_to_many :unit_types

end
