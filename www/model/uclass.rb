require 'generalization'

class UClass < ActiveRecord::Base

    has_many :specializations, :class_name => 'Generalization',  :foreign_key => "parent_id"
    has_many :sub_classes, :class_name => 'UClass', :through => :specializations, :source => 'child'

    has_many :generalizations, :foreign_key => "child_id"
    has_many :super_classes, :class_name => 'UClass', :through => :generalizations, :source => 'parent'

    belongs_to :visibility

    has_many :u_attributes, :foreign_key => 'type_id'

end
