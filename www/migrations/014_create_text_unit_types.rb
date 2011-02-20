class CreateTextUnitTypes < ActiveRecord::Migration

    def self.up
	create_table :text_unit_types do |t|
	    t.string	:name
	end
    end

    def self.down
	drop_table :text_unit_types
    end

end
