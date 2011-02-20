class Unit < ActiveRecord::Base

    belongs_to :project
    belongs_to :unit_type
    has_many :from_associations, :class_name => 'Association', :foreign_key => 'from_id'
    has_many :to_associations, :class_name => 'Association', :foreign_key => 'to_id'
    has_many :text_units

end
