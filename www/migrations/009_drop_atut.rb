class DropAtut < ActiveRecord::Migration

    def self.up
	drop_table :association_types_unit_types
    end

    def self.down
        create_table :association_types_unit_types, :id => false do |t|
	    t.integer :association_type_id
            t.integer :from_unit_type_id
            t.integer :to_unit_type_id
	    t.integer :min
            t.integer :max
        end
    end

end
