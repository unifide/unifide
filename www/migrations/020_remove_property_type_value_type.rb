class RemovePropertyTypeValueType < ActiveRecord::Migration

    def self.up
	remove_column :property_types, :value_type
    end

    def self.down
	add_column :property_types, :value_type, :string
    end

end
