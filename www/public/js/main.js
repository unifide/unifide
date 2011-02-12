// Here is our main instance - shuold be the only globally accessible object
app = null;

// Start our app once it's all loaded.
$(window).load(function() {
    app = new Magnifide();
});

// Magnifide is our application class
var Magnifide = Class.extend({
init: function() {
    this.theme = 0;
    this.project = new Project();
    this.editors = [];
    this.editors.push(new Editor());
    $("button").button();
    $("button#theme-toggle").button().click(this.toggleTheme);
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
}
});
