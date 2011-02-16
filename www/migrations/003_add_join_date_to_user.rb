class AddJoinDateToUser < ActiveRecord::Migration

    def self.up
        add_column :users, :join_date, :datetime, :null => false
    end

    def self.down
        remove_column :users, :join_date
    end
end
