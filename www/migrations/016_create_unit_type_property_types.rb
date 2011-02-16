class CreateUnitTypePropertyTypes < ActiveRecord::Migration

    def self.up
	create_table :unit_type_property_types, :id => false do |t|
	    t.integer	:property_type_id
	    t.integer	:unit_type_id
	end
    end

    def self.down
	drop_table :unit_type_property_types
    end
end
