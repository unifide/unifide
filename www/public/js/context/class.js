var ClassContext = Context.extend({
init:function(editor, parent) {
    this._super(editor, parent);

    this.elem = $('<div class="context-elem">ClassName</div>')
        .appendTo(this.parent.elem)
        .css({
            "position":"absolute",
            "margin":"5px",
            "font":"bold 12px sans",
            "color":"black",
            "border":"1px solid black"
        });
},

destroy:function() {
    this.elem.remove();
},

resize:function() {
    this.elem.css({
        width:this.width,
        height:this.height,
        top:this.top,
        left:this.left,
    });
},

draw:function() {
/*    var ctx = app.canvas.ctx;

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
    ctx.fillText("PackageContext canvas test",this.width/2,this.height/2);*/
}
});
