class Visibility
	include DataMapper::Resource

	property :id, Serial, :required => true, :key => true
	property :name, String, :required => true, :unique => true

	has n, :mclasses, 'MClass'

end
