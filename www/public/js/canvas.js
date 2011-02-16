var Canvas = Class.extend({
init: function(id) {
    this.elem = document.getElementById("canvas");
    this.ctx = this.elem.getContext("2d");

    if(this.ctx) this.supported = true;
    else this.supported = false;

    this.resize();
},

resize: function() {
    this.width = $(window).width();
    this.height = $(window).height();

    this.elem.width = this.width;
    this.elem.height = this.height;

    $(this.elem).css({
        width:this.width,
        height:this.height
    });
}
});
