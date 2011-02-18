class ChangeAssociationsToFromTo < ActiveRecord::Migration

    def self.up
	rename_column :associations, :parent_id, :from_id
	rename_column :associations, :child_id, :to_id
    end

    def self.down
	rename_column :associations, :from_id, :parent_id
	rename_column :associations, :to_id, :child_id
    end

end
