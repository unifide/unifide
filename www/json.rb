class JSONReply
    def JSONReply.reply(type,name,depth)
        if type == "Package" and name == "MyPackage" then
            return <<-EOF
[["Package","MyPackage",{"hasChild":[1,2]}],
["Interface","MyPackage.SomeInterface",{"hasKeyword":[3],"hasMethod":[4]}],
["Class","MyPackage.MyClass",{"implements":[1],"hasKeyword":[3,5],"hasMethod":[6]}],
["Keyword","public",{}],
["Method","MyPackage.SomeInterface.AMethod",{}],
["Keyword","abstract",{}],
["Method","MyPackage.MyClass.AMethod",{"implements":[4]}]]
EOF
        else
            return '{"error":"No reply for '+type+'/'+name+' (depth:'+depth+')"}'
        end
    end
end
