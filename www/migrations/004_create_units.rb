class CreateUnits < ActiveRecord::Migration

    def self.up
	create_table :units do |t|
	    t.integer	:unit_type_id
	    t.string	:value
	end
    end

    def self.down
	drop_table :units
    end
end
