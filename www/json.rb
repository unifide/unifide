class JSONReply
    def JSONReply.reply(type,name,depth)
        if type == "Package" and name == "MyPackage" then
            return <<-EOF
[["Package","MyPackage",{"hasChild":[1,2],"hasGeometry":[7]}],
["Interface","MyPackage.SomeInterface",{"hasKeyword":[3],"hasMethod":[4],"hasGeometry":[7]}],
["Class","MyPackage.MyClass",{"hasInterface":[1],"hasKeyword":[3,5],"hasMethod":[6],"hasGeometry":[9]}],
["Keyword","public",{}],
["Method","MyPackage.SomeInterface.AMethod",{}],
["Keyword","abstract",{}],
["Method","MyPackage.MyClass.AMethod",{"hasInterface":[4]}],
["Geometry","100x80+0+0",{}],
["Geometry","20x20+20+10",{}],
["Geometry","20x20+60+10",{}]]
EOF
        else
            return '{"error":"No reply for '+type+'/'+name+' (depth:'+depth+')"}'
        end
    end
end
