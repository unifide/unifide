require 'model'

User.delete_all
Project.delete_all
Unit.delete_all
UnitType.delete_all
Association.delete_all
AssociationType.delete_all
TextUnit.delete_all
TextUnitType.delete_all

def makeAssocType(type)
    AssociationType.create(:name => type)
end

def makeUnitType(type)
    UnitType.create(:name => type)
end

def makeTextUnitType(type)
    TextUnitType.create(:name => type)
end

def makeAssoc(from, type, to)
    Association.create :association_type => type, :from => from, :to => to
end

def makeUnit(type, name)
    unit = Unit.create(:unit_type => type, :value => name, :project => Project.where(:name => "Default").first)
    return unit
end

admin = User.create(:username => "unifide", :first_name => "Uni", :second_name => "Fide", :email => "admin@unifide.com", :password => "admin", :join_date => DateTime.now)
defaultProject = Project.create(:short_name => "default", :name => "Default", :public => true)
ProjectUser.create(:project => defaultProject, :user => admin, :admin => true)

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

code = makeTextUnitType("Code")
docs = makeTextUnitType("Documentation")

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
javalangpack = makeUnit(packageType, "java.lang")

obj = makeUnit classType, "java.lang.Object"
str = makeUnit classType, "java.lang.String"
lst = makeUnit interfaceType, "java.util.List"

t = makeUnit templateParameter, "T"

tostr = makeUnit methodType, "toString"

TextUnit.create :text_unit_type => code, :text => "return something;", :unit => tostr
TextUnit.create :text_unit_type => docs, :text => "Returns a String.", :unit => tostr

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
