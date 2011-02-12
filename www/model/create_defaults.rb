require 'model'
publick = Visibility.first_or_create(:name => "public")
proteckted = Visibility.first_or_create(:name => "protected")
privit = Visibility.first_or_create(:name => "private")
defolt = Visibility.first_or_create(:name => "default")

def makeType(name, vis)
  UClass.first_or_create({:name => name}, {:name => name, :visibility => vis})
end
	
makeType('Integer', publick)
makeType('Double', publick)
makeType('String', publick)
