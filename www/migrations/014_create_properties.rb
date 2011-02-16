class CreateProperties < ActiveRecord::Migration

    def self.up
	create_table :unit_properties do |t|
	    t.integer	:unit_id
	    t.integer	:property_type_id
	    t.integer	:value_id
	    t.string	:value_literal
	end
    end

    def self.down
	drop_table :unit_properties
    end
end
