var CodeProcessor = Class.extend({
init:function() {},
process:function(type, name, container, loader, callback) {
    var obj = {
        loader:loader,
        callback:callback,
        processor:this,
        container:container
    };
    loader.start(obj, type+", "+name);
    
    // get the required data
    app.data.fetch(type,name,$.proxy(function(unit) {
        var context = null;

        // make and return the appropriate context
        switch(unit.type) {
            case "Package":
                context = this.processor.createPackageContext(container, unit);
                break;
            case "Class":
                context = this.processor.createClassContext(container, unit);
                break;
        }

        if(this.callback) {
            this.callback(context);
        }
        this.loader.end(obj);
    },obj));
},
createPackageContext:function(container, unit) {
    var package = new PackageContext(container);

    package.name(unit.name);

    unit.isOwnerOf.each(function(child) {
        package.addChild(child);
    });

    return package;
},
createClassContext:function(container, unit) {
    return new ClassContext(container);
}
});
