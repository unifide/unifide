class Generalization < ActiveRecord::Base

	belongs_to :parent, :class_name => "UClass"
	belongs_to :child, :class_name => "UClass"

end
