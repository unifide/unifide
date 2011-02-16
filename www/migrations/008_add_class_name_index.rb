class AddClassNameIndex < ActiveRecord::Migration

    def self.up
        add_index :u_classes, :name, :unique => true
    end

    def self.down
        remove_index :u_classes, :name
    end
end
