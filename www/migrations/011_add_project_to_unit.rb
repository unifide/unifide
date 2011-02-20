class AddProjectToUnit < ActiveRecord::Migration

    def self.up
	add_column :units, :project_id, :integer
    end

    def self.down
	remove_column :units, :project_id
    end

end
