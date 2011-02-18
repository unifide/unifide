class AddDefaultToPropertyValues < ActiveRecord::Migration

    def self.up
	add_column :property_values, :is_default, :boolean
    end

    def self.down
	remove_column :property_values, :is_default
    end

end
