var Context = Class.extend({
init:function(editor, parent) {
    this.editor = editor;
    this.parent = parent;

    this.units = []; // any child contexts go here
    this.top = 0; // the offset from the top for the current context
    this.left = 0; // offset from the left
    this.width = parent.width; // width allocated to the context
    this.height = parent.height; // allocated height
}
});

var ProjectContext = Context.extend({
init:function(editor, parent) {
    this._super(editor, editor);

    this.resize();
    this.draw();

    this.elem = $('<div class="context-elem">ProjectContext HTML test</div>')
        .appendTo(this.parent.elem)
        .css({
            "position":"absolute",
            "top":"0px",
            "left":"0px",
            "margin":"5px",
            "font":"bold 12px sans",
            "color":"black"
        });
},

resize:function() {
    this.width = this.editor.width;
    this.height = this.editor.height;
},

draw:function() {
    var ctx = this.editor.canvas.ctx;

    ctx.beginPath();
    ctx.moveTo(0,0);
    ctx.lineTo(0.5,this.height-0.5);
    ctx.lineTo(this.width-0.5,this.height-0.5);
    ctx.lineTo(this.width-0.5,0.5);
    ctx.lineTo(0.5,0.5);

    ctx.lineTo(this.width,this.height);
    ctx.moveTo(0,this.height);
    ctx.lineTo(this.width,0);
    ctx.strokeStyle = "rgba(255,255,255,0.5)";
    ctx.stroke();

    ctx.font = "bold 12px sans";
    ctx.textBaseline = "middle";
    ctx.textAlign = "center";
    ctx.fillText("ProjectContext canvas test",this.width/2,this.height/2);
}
});
