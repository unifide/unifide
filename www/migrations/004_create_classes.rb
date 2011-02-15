class CreateClasses < ActiveRecord::Migration

	def self.up
		create_table :u_classes do |t|
			t.string 	:name
			t.datetime 	:creation_time
			t.integer 	:visibility_id
		end
	end

	def self.down
		drop_table :u_classes
	end
end
