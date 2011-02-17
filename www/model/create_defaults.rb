require 'model'

UnitType.delete_all

packageType = UnitType.create(:name=>"Package")
classType = UnitType.create(:name=>"Class")
methodType = UnitType.create(:name=>"Method")
attributeType = UnitType.create(:name=>"Attribute")

PropertyType.delete_all
vis = PropertyType.create(:name => "Visibility")

PropertyValue.delete_all
pub = PropertyValue.create(:value => "Public", :property_type => vis)
prot = PropertyValue.create(:value => "Protected", :property_type => vis)
priv = PropertyValue.create(:value => "Private", :property_type => vis)

classType.property_types << vis
classType.save
methodType.property_types << vis
methodType.save
attributeType.property_types << vis
attributeType.save

AssociationType.delete_all
#Generalization, subclass -> superclass
genType = AssociationType.create(:name=>"Generalization")
#Ownership, class -> method
ownerType = AssociationType.create(:name=>"Owner")

Unit.delete_all
obj = Unit.create(:unit_type => classType, :name => "Object", :creation_time => DateTime.now)
str = Unit.create(:unit_type => classType, :name => "String", :creation_time => DateTime.now)

UnitProperty.delete_all
UnitProperty.create(:unit => obj, :property_type => vis, :property_value => pub)

Association.delete_all
Association.create(:association_type => genType, :parent => obj, :child => str)
