class UnitType < ActiveRecord::Base

    has_many :units
    has_many :from_association_types, :class_name => 'AssociationTypeUnitType', :foreign_key => 'from_unit_type_id'
    has_many :to_association_types, :class_name => 'AssociationTypeUnitType', :foreign_key => 'to_unit_type_id'

end
