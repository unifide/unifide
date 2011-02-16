class CreateUnits < ActiveRecord::Migration

    def self.up
	create_table :units do |t|
	    t.integer	:unit_type_id
	    t.string	:name
	    t.datetime	:creation_time
	    t.integer	:creator_id
	end
    end

    def self.down
	drop_table :units
    end
end
