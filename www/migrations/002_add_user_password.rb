class AddUserPassword < ActiveRecord::Migration

    def self.up
        add_column :users, :password_hash, :string, :null => false
    end

    def self.down
        remove_column :users, :password_hash
    end
end
