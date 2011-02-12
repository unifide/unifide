class MAttribute
	include DataMapper::Resource

	property :name,	String, :key => true
	property :visibility_id, Integer, :required => true
	property :owner_id, Integer, :required => true
	property :mtype_id, Integer, :required => true

	belongs_to :owner, 'MClass', :key => true
	belongs_to :visibility, :required => true
	belongs_to :mtype, 'MClass', :required => true
	
end
