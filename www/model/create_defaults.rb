require 'model'

def makeATUT(from, at, to, min, max)
    AssociationTypeUnitType.create(:from_unit_type => from, :association_type => at, :to_unit_type => to, :min => min, :max => max)
end

def makeAssoc(from, type, to)
    Association.create :association_type => type, :from => from, :to => to
end

def makeUnit(type, name)
    unit = Unit.create(:unit_type => type, :value => name)
    return unit
end

Unit.delete_all
UnitType.delete_all
Association.delete_all
AssociationType.delete_all
AssociationTypeUnitType.delete_all

packageType = UnitType.create(:name=>"Package")
classType = UnitType.create(:name=>"Class")
methodType = UnitType.create(:name=>"Method")
attributeType = UnitType.create(:name=>"Attribute")
visibilityType = UnitType.create(:name=>"Visibility")
booleanType = UnitType.create(:name=>"Boolean")

hasname = AssociationType.create(:name=>"hasName")
extends = AssociationType.create(:name=>"hasSuperclass")
hasowner = AssociationType.create(:name=>"hasOwner")

makeATUT classType, extends, classType, 0, 1
makeATUT classType, hasowner, packageType, 1, 1
makeATUT classType, hasowner, classType, 0, 1
makeATUT methodType, hasowner, classType, 1, 1
makeATUT packageType, hasowner, packageType, 0, 1

pub = makeUnit(visibilityType, "Public")
prot = makeUnit(visibilityType, "Protected")
priv = makeUnit(visibilityType, "Private")

javapack = makeUnit(packageType, "java")
javalangpack = makeUnit(packageType, "lang")

obj = makeUnit classType, "Object"
str = makeUnit classType, "String"

tostr = makeUnit methodType, "toString"

makeAssoc str, extends, obj
makeAssoc str, hasowner, javalangpack
makeAssoc obj, hasowner, javalangpack
makeAssoc javalangpack, hasowner, javapack
makeAssoc tostr, hasowner, obj
