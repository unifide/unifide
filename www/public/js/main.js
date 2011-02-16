// Here is our main instance - shuold be the only globally accessible object
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
    this.canvas = new Canvas("canvas");
    this.project = new Project();
    this.editors = [];
    this.editors.push(new Editor($("#editor")));

    for(var e=0;e<this.editors.length;e++) {
        this.editors[e].resize();
        this.editors[e].draw();
    }

    $(window).resize($.proxy(app.resize,this));

    $("#settings a").click(function() { $("#settings-box").slideToggle(); });
    $("#theme-toggle").click(this.toggleTheme);
    
    $("button").button();
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
    this.canvas.resize();
    for(var e=0;e<this.editors.length;e++) {
        this.editors[e].resize();
        this.editors[e].draw();
    }
}
});
