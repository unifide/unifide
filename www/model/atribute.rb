class Atribute
	include DataMapper::Resource

	property :name,	String, :key => true

	belongs_to :klass, :key => true
	
end
