class Association < ActiveRecord::Base

    belongs_to :association_type
    belongs_to :parent, :class_name => 'Unit'
    belongs_to :child, :class_name => 'Unit'
end
