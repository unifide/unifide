class AssociationType < ActiveRecord::Base

    has_many :associations
    has_many :unit_types_association_types

end
