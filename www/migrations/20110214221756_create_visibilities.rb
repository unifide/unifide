class CreateVisibilities < ActiveRecord::Migration

	def self.up
		create_table :visibilities do |t|
			t.string	:name
		end
	end

	def self.down
		drop_table :visibilities
	end
end
