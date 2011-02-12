class UAttribute
	include DataMapper::Resource

	property :name,	String, :key => true
	property :visibility_id, Integer, :required => true
	property :owner_id, Integer, :required => true
	property :utype_id, Integer, :required => true

	belongs_to :owner, 'UClass', :key => true
	belongs_to :visibility, :required => true
	belongs_to :utype, 'UClass', :required => true
	
end
