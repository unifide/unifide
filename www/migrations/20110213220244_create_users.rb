class CreateUsers < ActiveRecord::Migration

	def self.up
		create_table :users do |t|
			t.column :first_name, :string, :null => false
			t.column :second_name, :string, :null => false
			t.column :email, :string, :null => false
		end
	end

	def self.down
		drop_table :users
	end

end
