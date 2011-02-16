class CreateAssociations < ActiveRecord::Migration

    def self.up
	create_table :associations, :id => false do |t|
	    t.string	:name
	    t.integer	:parent_id
	    t.integer	:child_id
	end
    end

    def self.down
	drop_table :associations
    end
end
