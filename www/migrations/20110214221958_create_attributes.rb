class CreateAttributes < ActiveRecord::Migration

	def self.up
		create_table :u_attributes do |t|
			t.string	:name
			t.integer	:owner_id
			t.integer	:type_id
			t.integer	:visibility_id
			t.datetime	:creation_time
		end
	end

	def self.down
		drop_table :u_attributes
	end
end
