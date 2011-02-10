class Klass
	include DataMapper::Resource

	property :id,	Serial
	property :name,	String
	property :creationTime,	DateTime

	has n, :atributes
end
