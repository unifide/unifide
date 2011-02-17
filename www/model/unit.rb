class Unit < ActiveRecord::Base
    
    belongs_to :unit_type
    has_many :parent_associations, :class_name => 'Association', :foreign_key => 'child_id'
    has_many :child_associations, :class_name => 'Association', :foreign_key => 'parent_id'
    has_many :properties

end
