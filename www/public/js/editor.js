var Editor = Class.extend({
init: function(elem) {
    this.elem = elem;

    this.resize(); // first resize makes sure everything is the right size
    this.root = new PackageContext(this, this);
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
    this.top = this.elem.offset().top;
    this.left = this.elem.offset().left;
    this.width = this.elem.width();
    this.height = this.elem.height();

    if(this.root)
        this.root.resize();
},
});
