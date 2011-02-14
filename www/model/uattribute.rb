class UAttribute < ActiveRecord::Base

	belongs_to :owner, :class_name => 'UClass'
	belongs_to :visibility
	belongs_to :type, :class_name => 'UClass'
	
end
