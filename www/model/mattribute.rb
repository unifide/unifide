class MAttribute
	include DataMapper::Resource

	property :name,	String, :key => true

	belongs_to :mclass, 'MClass', :key => true
	
end
