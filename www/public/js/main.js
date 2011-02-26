// Here is our main instance - should be the only globally accessible object
app = null;

// Start our app once it's all loaded.
$(window).load(function() {
    if($("#canvas").length){
        app = new Unifide();
        app.run();
    }
});


// Unifide is our application class
var Unifide = Class.extend({
init: function() {
    this.theme = 0;
},

run: function() {
    this.loader = new Loader();
    this.topbar = new TopBar();
    this.project = new Project();
    this.actions = new ActionStack();
    this.data = new DataRepository();
    this.processor = new CodeProcessor();

    this.canvas = new Canvas("canvas");
    this.editors = [];
    this.editors.push(new Editor($("#editor")));

    this.loader.onLoad($.proxy(function() {
        this.resize();

        $(window).resize($.proxy(app.resize,this));
    },this));
},

toggleTheme: function() {
    if(this.theme == "light")
        this.theme = "dark";
    else
        this.theme = "light";
    var theme = this.theme;
    $("link.theme").each(function() {
        if($(this).attr("title") == theme)
            $(this).removeAttr("disabled");
        else
            $(this).attr("disabled","disabled");
    });
},

resize: function() {
    $("#fullscreen").height($(window).height() - $("#topbar").height() - 1)
    this.canvas.resize();
    for(var e=0;e<this.editors.length;e++) {
        this.editors[e].resize();
        this.editors[e].draw();
    }
},
});
