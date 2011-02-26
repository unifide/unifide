var Editor = Class.extend({
init: function(elem) {
    this.parent = elem;
    this.elem = $("<div/>").appendTo(elem).addClass("contextDiv");

    this.resize(); // first resize makes sure everything is the right size
    this.root = app.processor.process("Package","MyPackage",this.elem,
        app.loader,function(context) {this.root = context;});
    this.root = new UnifideContext(this, this, "MyPackage");
},

destroy: function() {
    if(this.root)
        this.root.destroy();
},

resize: function() {
    this.top = this.parent.offset().top;
    this.left = this.parent.offset().left;
    this.width = this.parent.width();
    this.height = this.parent.height();
    
    this.elem.css({
        top:this.top,
        left:this.left,
        width:this.width,
        height:this.height
    });

    if(this.root) {
        this.root.top = this.top;
        this.root.left = this.left;
        this.root.width = this.width;
        this.root.height = this.height;

        this.root.resize();
    }
},
});
