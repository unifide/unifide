var PackageContext = Context.extend({
init:function(editor, parent, package) {
    this._super(editor, parent);

    this.label = "PackageContext: "+package;
    app.loader.start(this,this.label);

    app.data.fetch("Package",package,$.proxy(function(unit){
        this.package = unit;

        this.elem = $('<div class="context-elem">'+this.package.name+'</div>')
            .appendTo(this.parent.elem)
            .css({
                "position":"absolute",
                "top":"0px",
                "left":"0px",
                "margin":"5px",
                "font":"bold 12px sans",
                "color":"black",
                "border":"1px solid black"
            });

        this.class = new ClassContext(editor,this);
        app.loader.end(this);
    },this),2);
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
