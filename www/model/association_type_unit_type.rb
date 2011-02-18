class AssociationTypeUnitType < ActiveRecord::Base

    set_table_name "association_types_unit_types"

    belongs_to :association_type
    belongs_to :from_unit_type, :class_name => 'UnitType'
    belongs_to :to_unit_type, :class_name => 'UnitType'

end
