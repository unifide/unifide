var theme = 0;

$(window).load(function() {
    $("button").button().click(toggleTheme);
});

function toggleTheme() {
    if(theme == "light") theme = "dark";
    else theme = "light";
    $("link.theme").each(function() {
        if($(this).attr("title") == theme)
            $(this).removeAttr("disabled");
        else
            $(this).attr("disabled","disabled");
    });
}
