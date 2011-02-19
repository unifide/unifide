var CodeProcessor = Class.extend({
init:function() {},
process:function(type, name, loader, callback) {
    var obj = {
        loader:loader,
        callback:callback,
        processor:this
    };
    loader.start(obj, type+", "+name);
    
    // get the required data
    app.data.fetch(type,name,$.proxy(function(unit) {
        var context = null;

        // make and return the appropriate context
        switch(unit.type) {
            case "Package":
                context = this.processor.createPackageContext(unit);
                break;
            case "Class":
                context = this.processor.createClassContext(unit);
                break;
        }

        if(this.callback) {
            this.callback(context);
        }
        this.loader.end(obj);
    },obj));
},
createPackageContext:function(unit) {
    var package = new PackageContext();

//    package.name(unit.name);

    return package;
},
createClassContext:function(unit) {
    return new ClassContext();
}
});
