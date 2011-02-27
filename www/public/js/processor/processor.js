var CodeProcessor = Class.extend({
init:function() {},
process:function(type, name, options) {
    options.processor = this;
    
    // get the required data
    app.data.fetch(type,name,$.proxy(function(unit) {
        switch(unit.type) {
            case "Package":
                this.processor.createPackageContext(this, unit);
                break;
            case "Class":
                this.processor.createClassContext(this, unit);
                break;
        }
    },options));
},
createPackageContext:function(options, unit) {
    var package = new PackageContext(options);

    package.name(unit.name);

    unit.isOwnerOf.each(function(child) {
        package.addChild(child);
    });

    return package;
},
createClassContext:function(options, unit) {
    return new ClassContext(options);
}
});
