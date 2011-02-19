var Editor = Class.extend({
init: function(elem) {
    this.parent = elem;
    this.elem = $("<div/>").appendTo(elem).addClass("contextDiv");

    this.resize(); // first resize makes sure everything is the right size
    this.root = app.processor.process("Package","MyPackage",app.loader,
        function(context) {this.root = context;});
    //this.root = new PackageContext(this, this, "MyPackage");
},

destroy: function() {
    if(this.root)
        this.root.destroy();
},

draw: function() {
    app.canvas.ctx.save();
    app.canvas.ctx.translate(this.left,this.top);
    if(this.root)
        this.root.draw();
    app.canvas.ctx.restore();
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
