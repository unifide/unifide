class PropertyType < ActiveRecord::Base

    has_many :properties
    has_and_belongs_to_many :unit_types

end
