$(window).load(function() {
    new Magnifide();
});

var Magnifide = Class.extend({
init: function() {
    this.theme = 0;
    $("button").button().click(this.toggleTheme);
},

toggleTheme: function() {
        if(this.theme == "light") this.theme = "dark";
        else this.theme = "light";
        var theme = this.theme;
        $("link.theme").each(function() {
            if($(this).attr("title") == theme)
                $(this).removeAttr("disabled");
            else
                $(this).attr("disabled","disabled");
        });
    }
});
