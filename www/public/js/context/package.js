var PackageContext = Context.extend({
init:function(options) {
    this._super(options);

//    this.elem = $('<div style="margin:5px"/>');
    this.titleBar = $('<h2/>').appendTo(this.options.content);
    this.children = $('<div>'+
        'Packages:<br/><ul class="pkg_packages"/>'+
        'Classes:<br/><ul class="pkg_classes"/>'+
        'Interfaces:<br/><ul class="pkg_interfaces"/>'+
        '</div>').appendTo(this.options.content);
},

destroy:function() {
},

resize:function() {
    this.class.top = 60;
    this.class.left = 120;
    this.class.width = 200;
    this.class.height = 100;
    this.class.resize();
},

addChild:function(child) {
    switch(child.type) {
        case "Class":
            $(".pkg_classes",this.children).append("<li>"+child.name+"</li>");
            break;
        case "Interface":
            $(".pkg_interfaces",this.children).append("<li>"+child.name+"</li>");
            break;
        case "Package":
            $(".pkg_packages",this.children).append("<li>"+child.name+"</li>");
            break;
        default:
            console.log("Unhandled child type '"+child.type+"' for '"+child.name+"'");
            
    }
}
});
