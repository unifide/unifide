class Association < ActiveRecord::Base

    belongs_to :association_type
    belongs_to :from, :class_name => 'Unit'
    belongs_to :to, :class_name => 'Unit'

    def self.get_relationships(units)
	ids = units.collect {|u| u.id}
	Association.where(:from_id => ids, :to_id => ids)
    end
end
