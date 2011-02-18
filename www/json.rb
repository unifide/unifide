class JSONReply
    def JSONReply.reply(context,query)
        case context
        when 'Editor'
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
            return '{"error":"No reply for '+context+'/'+query+'"}'
        end
    end
end
