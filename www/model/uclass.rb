class UClass
	include DataMapper::Resource

	property :id,	Serial
	property :name,	String, :required => true, :unique => true
	property :creation_time,	DateTime, :required => true, :default => DateTime.now
	property :visibility_id, Integer, :required => true

	has n, :uattributes, 'UAttribute', :child_key => [:owner_id]

	has n, :generalizations, 'Generalization', :child_key => [ :parent_id ]
	has n, :child_uclasses, self, :through => :generalizations, :via => :child

	has n, :specializations, 'Generalization', :child_key => [ :child_id ]
	has n, :base_uclasses, self, :through => :specializations, :via => :parent

	belongs_to :visibility
end

class Generalization
	include DataMapper::Resource

	property :parent_id, Integer, :key => true
	property :child_id, Integer, :key => true

	belongs_to :parent, 'UClass', :key => true
	belongs_to :child, 'UClass', :key => true
end
