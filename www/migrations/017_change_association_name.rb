class ChangeAssociationName < ActiveRecord::Migration

    def self.up
	remove_column :associations, :name
	add_column :associations, :association_type_id, :integer
    end

    def self.down
	add_column :associations, :name, :string
	remove_column :associations, :association_type_id
    end
end
