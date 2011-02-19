require 'model'

Unit.delete_all
UnitType.delete_all
Association.delete_all
AssociationType.delete_all

def makeAssocType(type)
    AssociationType.create(:name => type)
end

def makeUnitType(type)
    UnitType.create(:name => type)
end

def makeAssoc(from, type, to)
    Association.create :association_type => type, :from => from, :to => to
end

def makeUnit(type, name)
    unit = Unit.create(:unit_type => type, :value => name)
    return unit
end

packageType = makeUnitType("Package")
tableType = makeUnitType("Table")
actorType = makeUnitType("Actor")
objectType = makeUnitType("Object")
classType = makeUnitType("Class")
interfaceType = makeUnitType("Interface")
methodType = makeUnitType("Method")
argType = makeUnitType("Argument")
attributeType = makeUnitType("Attribute")
geometryType = makeUnitType("Geometry")
keywordType = makeUnitType("Keyword")
templateParameter = makeUnitType("TemplateParameter")

extends = makeAssocType("Superclass")
hasowner = makeAssocType("Owner")
hasgeo = makeAssocType("Geometry")
hasunit = makeAssocType("Unit")
haskeyword = makeAssocType("Keyword")
hasTemplateParam = makeAssocType("TemplateParameter")
hasType = makeAssocType("Type")

pub = makeUnit(keywordType, "public")
prot = makeUnit(keywordType, "protected")
priv = makeUnit(keywordType, "private")

javapack = makeUnit(packageType, "java")
javalangpack = makeUnit(packageType, "lang")

obj = makeUnit classType, "Object"
str = makeUnit classType, "String"
lst = makeUnit interfaceType, "List"

t = makeUnit templateParameter, "T"

tostr = makeUnit methodType, "toString"

makeAssoc obj, haskeyword, pub
makeAssoc str, haskeyword, pub
makeAssoc lst, haskeyword, pub
makeAssoc tostr, haskeyword, pub

makeAssoc str, extends, obj
makeAssoc str, hasowner, javalangpack
makeAssoc obj, hasowner, javalangpack
makeAssoc javalangpack, hasowner, javapack
makeAssoc tostr, hasowner, obj
makeAssoc tostr, hasType, str
makeAssoc t, extends, obj
makeAssoc lst, hasTemplateParam, t
