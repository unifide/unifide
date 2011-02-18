class CreateAssociationTypesUnitTypes < ActiveRecord::Migration

    def self.up
	create_table :association_types_unit_types, :id => false do |t|
	    t.integer :association_type_id
	    t.integer :from_unit_type_id
	    t.integer :to_unit_type_id
	    t.integer :min
	    t.integer :max
	end
    end

    def self.down
	drop_table :association_types_unit_types
    end

end
