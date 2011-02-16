require 'model'
publick = Visibility.create(:name => "public")
proteckted = Visibility.create(:name => "protected")
privit = Visibility.create(:name => "private")
defolt = Visibility.create(:name => "default")

def makeType(name, vis)
  UClass.create(:name => name, :visibility => vis)
end
    
makeType('Integer', publick)
makeType('Double', publick)
makeType('String', publick)
