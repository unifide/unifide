require 'model'

UnitType.delete_all

packageType = UnitType.create(:name=>"Package")
classType = UnitType.create(:name=>"Class")
methodType = UnitType.create(:name=>"Method")
attributeType = UnitType.create(:name=>"Attribute")

AssociationType.delete_all
#Generalization, subclass -> superclass
genType = AssociationType.create(:name=>"Generalization")
#Ownership, class -> method
ownerType = AssociationType.create(:name=>"Owner")

Unit.delete_all
obj = Unit.create(:unit_type => classType, :name => "Object", :creation_time => DateTime.now)
str = Unit.create(:unit_type => classType, :name => "String", :creation_time => DateTime.now)

Association.delete_all
Association.create(:association_type => genType, :parent => obj, :child => str)
