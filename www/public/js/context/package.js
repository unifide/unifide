var PackageContext = Context.extend({
init:function(container) {
    this._super(container);

    this.elem = $('<div style="margin:5px"/>').appendTo(container);
    this.titleBar = $('<h2/>').appendTo(this.elem);
    this.children = $('<div>'+
        'Packages:<br/><ul class="pkg_packages"/>'+
        'Classes:<br/><ul class="pkg_classes"/>'+
        'Interfaces:<br/><ul class="pkg_interfaces"/>'+
        '</div>').appendTo(this.elem);
},

destroy:function() {
    this.class.destroy();

    this.elem.remove();
},

resize:function() {
    this.class.top = 60;
    this.class.left = 120;
    this.class.width = 200;
    this.class.height = 100;
    this.class.resize();
},

name:function(val) {
    if(val) {
        this._name = val;
        this.titleBar.text(this._name);
    } else {
        return this._name;
    }
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
