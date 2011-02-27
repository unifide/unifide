var Editor = Class.extend({
init: function(elem,index) {
    this.parent = elem;
    this.index = index;
    this.elem = $("<div/>").appendTo(this.parent).addClass("contextDiv");
    this.tabs = $("<div/>").appendTo(this.elem);
    this.current = {};

    var tab = this.newTab();
    tab.title.text("Start Page");
    tab.content.append("<h1>START PAGE!!</h1>");
    
    app.processor.process("Package","java.lang",this.newTab());

    this.resize();
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

newTab:function() {
    var title = $("<button>&nbsp;</button>")
        .button()
        .appendTo(this.tabs);
    var content = $('<div style="display:none"/>').appendTo(this.elem);

    var opts = {
        id:this.nextId++,
        editor:this,
        content:content,
        title:$("span", title)
    };
    title.click($.proxy(this.selectTab,opts));

    $.proxy(this.selectTab,opts);

    return opts;
},

selectTab:function() {
    if($.isEmptyObject(this.editor.current)) {
        this.editor.current.elem = this.content;
        this.editor.current.id = this.id;
        this.editor.current.elem.show();
    } else if(this.editor.current.id != this.id) {
        this.editor.current.elem.hide();
        this.editor.current.elem = this.content;
        this.editor.current.id = this.id;
        this.editor.current.elem.show();
    }
}
});
