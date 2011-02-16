class CreatePropertyValues < ActiveRecord::Migration

    def self.up
	create_table :property_values do |t|
	    t.integer	:property_type_id
	    t.string	:value
	end
    end

    def self.down
	drop_table :property_values
    end
end
