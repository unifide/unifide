class CreateTextUnits < ActiveRecord::Migration

    def self.up
	create_table :text_units do |t|
	    t.integer	:unit_id
	    t.integer	:text_unit_type_id
	    t.text	:text
	end
    end

    def self.down
	drop_table :text_units
    end

end
