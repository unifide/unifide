class JSONReply
    def JSONReply.reply(type,name)
        if type == "Package" and name == "MyPackage" then
            return <<-EOF
{"type":"Package","name":"MyPackage","depth":3,"data":[
    ["Package","MyPackage",{"Child":[1,2],"Geometry":[7]}],
    ["Interface","MyPackage.SomeInterface",{"Keyword":[3],"Method":[4],"Geometry":[8]}],
    ["Class","MyPackage.MyClass",{"Interface":[1],"Keyword":[3,5],"Method":[6],"hasGeometry":[9]}],
    ["Keyword","public",{}],
    ["Method","MyPackage.SomeInterface.AMethod",{}],
    ["Keyword","abstract",{}],
    ["Method","MyPackage.MyClass.AMethod",{"Interface":[4]}],
    ["Geometry","ClassDiagram(Package:MyPackage)",{},{"width":"80","height":"80","top":"10","left":"10"}],
    ["Geometry","ClassDiagram(Interface:MyPacakge.SomeInterface)",{}],
    ["Geometry","ClassDiagram(Class:MyPackage.MyClass)",{}],
    ["ClassDiagram","MyPackage",{"Package":[0]}]
]}
EOF
            return '{"error":"No reply for '+type+'/'+name+'"}'
        end
    end
end
