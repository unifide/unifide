class MakeUtptPlural < ActiveRecord::Migration

    def self.up
	rename_table :unit_type_property_types, :property_types_unit_types
    end

    def self.down
	rename_table :property_types_unit_types, :unit_type_property_types
    end

end
