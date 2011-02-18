class CreateAssociations < ActiveRecord::Migration

    def self.up
	create_table :associations, :id => false do |t|
	    t.integer	:association_type_id
	    t.integer	:from_id
	    t.integer	:to_id
	end
    end

    def self.down
	drop_table :associations
    end
end
