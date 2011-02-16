class CreateGeneralizations < ActiveRecord::Migration

    def self.up
        create_table :generalizations, :id => false do |t|
            t.integer    :parent_id
            t.integer    :child_id
        end
    end

    def self.down
        drop_table :generalizations
    end
end
