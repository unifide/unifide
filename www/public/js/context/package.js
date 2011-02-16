var PackageContext = Context.extend({
init:function(editor, parent) {
    this._super(editor, parent);

    this.elem = $('<div class="context-elem">PackageContext HTML test</div>')
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

destroy:function() {
    this.elem.remove();
},

resize:function() {
    this.width = this.parent.width;
    this.height = this.parent.height;
    this.top = this.parent.top;
    this.left = this.parent.left;
},

draw:function() {
    var ctx = app.canvas.ctx;

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
    ctx.fillText("PackageContext canvas test",this.width/2,this.height/2);
}
});
