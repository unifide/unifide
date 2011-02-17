class ChangeUnitPropertyValue < ActiveRecord::Migration

    def self.up
	rename_column :unit_properties, :value_id, :property_value_id
    end

    def self.down
	rename_column :unit_properties, :property_value_id, :value_id
    end
end
