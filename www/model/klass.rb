class Klass
	include DataMapper::Resource

	property :id,	Serial
	property :name,	String, :required => true
	property :creationTime,	DateTime

	has n, :atributes
	has n, :generalizations, 'Generalization', :child_key => [ :parent_id ]
	has n, :child_klasses, self, :through => :generalizations, :via => :child
	has n, :specializations, 'Generalization', :child_key => [ :child_id ]
	has n, :base_klasses, self, :through => :specializations, :via => :parent
end

class Generalization
	include DataMapper::Resource

	property :parent_id, Integer, :key => true
	property :child_id, Integer, :key => true

	belongs_to :parent, 'Klass', :key => true
	belongs_to :child, 'Klass', :key => true
end
