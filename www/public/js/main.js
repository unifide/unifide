$(window).load(function() {
    $("button").button().click(function (){
        $.post("/json",function(json) {alert(json.a)});
    });
});
