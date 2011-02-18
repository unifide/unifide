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
extType = AssociationType.create(:name=>"Extends")
#Ownership, class -> method
ownerType = AssociationType.create(:name=>"Owned By")

AssociationTypeUnitType.delete_all
class_extends_class = AssociationTypeUnitType.create(:association_type => extType, :from_unit_type => classType, :to_unit_type => classType, :min => 0, :max => 1)
class_owned_by_package = AssociationTypeUnitType.create(:association_type => ownerType, :from_unit_type => classType, :to_unit_type => packageType, :min => 1, :max => 1)
method_owned_by_class = AssociationTypeUnitType.create(:association_type => ownerType, :from_unit_type => methodType, :to_unit_type => classType, :min => 1, :max => 1)

Unit.delete_all

javapack = Unit.create(:unit_type => packageType, :name => "java", :creation_time => DateTime.now)
javalangpack = Unit.create(:unit_type => packageType, :name => "lang", :creation_time => DateTime.now)

obj = Unit.create(:unit_type => classType, :name => "Object", :creation_time => DateTime.now)
str = Unit.create(:unit_type => classType, :name => "String", :creation_time => DateTime.now)

tostr = Unit.create(:unit_type => methodType, :name => "toString", :creation_time => DateTime.now)

UnitProperty.delete_all
UnitProperty.create(:unit => obj, :property_type => vis, :property_value => pub)
UnitProperty.create(:unit => tostr, :property_type => vis, :property_value => pub)

Association.delete_all
Association.create(:association_type => extType, :to => obj, :from => str)
Association.create(:association_type => ownerType, :from => obj, :to => tostr)
Association.create(:association_type => ownerType, :from => javalangpack, :to => javapack)
Association.create(:association_type => ownerType, :from => obj, :to => javalangpack)
Association.create(:association_type => ownerType, :from => str, :to => javalangpack)
