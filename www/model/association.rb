class Association < ActiveRecord::Base

    belongs_to :association_type
    belongs_to :from, :class_name => 'Unit'
    belongs_to :to, :class_name => 'Unit'
end
