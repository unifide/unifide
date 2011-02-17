class UnitType < ActiveRecord::Base

    has_and_belongs_to_many :property_types
    has_many :units

end
