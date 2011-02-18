class JSONReply
    def JSONReply.reply(context,query)
        case context
        when 'Editor'
            return <<-EOF
[
    ["Package","MyPackage",[
        ["hasChild","Interface","MyPackage.SomeInterface"],
        ["hasChild","Class","MyPackage.MyClass"]
    ]],
    ["Interface","MyPackage.SomeInterface",[
        ["hasKeyword","Keyword","public"],
        ["hasMethod","Method","MyPackage.SomeInterface.AMethod"]
    ]],
    ["Class","MyPackage.MyClass",[
        ["implements","Interface","MyPackage.SomeInterface"],
        ["hasKeyword","Keyword","public"],
        ["hasKeyword","Keyword","abstract"],
        ["hasMethod","Method","MyPackage.MyClass.AMethod"]
    ]],
    ["Method","MyPackage.MyClass.AMethod",[
        ["implements","Method","MyPackage.SomeInterface.AMethod"]
    ]]
]
EOF
        else
            return '{"error":"No reply for '+context+'/'+query+'"}'
        end
    end
end
