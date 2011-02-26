class AddProjectShortname < ActiveRecord::Migration

    def self.up
	add_column :projects, :short_name, :string
    end

    def self.down
	remove_column :projects, :short_name
    end

end
