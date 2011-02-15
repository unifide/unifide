var Editor = Class.extend({
init: function(elem) {
    this.elem = elem;
    this.elem.append("<canvas/>");
    this.canvas = $("canvas", this.elem);

    this.top = 0; // offsets
    this.left = 0;

    if(this.initCanvas()) {
        this.resize(); // first resize makes sure canvas is the right size
        this.root = new ProjectContext(this);
    } else {
        console.error("HTML5 Canvas not supported");
    }
},

initCanvas: function() {
    this.canvas.ctx = this.canvas.get(0).getContext("2d");
    if(!this.canvas.ctx) return false;
    return true;
},

resize: function() {
    this.width = this.elem.width();
    this.height = this.elem.height();
    this.canvas.css({
        "width":this.width+"px",
        "height":this.height+"px"
    });
    this.canvas.attr("width",this.width);
    this.canvas.attr("height",this.height);
   
    if(this.context)
        this.context.resize();
},
});
