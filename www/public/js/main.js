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
    this.loader = new Loader();
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

        $("#settings a").click(function() { $("#settings-box").slideToggle("fast"); });
        $("#user-settings a").click(this.showUserControls);
        $("#settings-box").mouseleave(function() { $("#settings-box").slideUp("fast"); });
        //$("#user-login-box").mouseleave(function() { $("#user-login-box").slideUp("fast"); });
        $("#user-settings-box").mouseleave(function() { $("#user-settings-box").slideUp("fast"); });
        $("#theme-toggle").click(this.toggleTheme);
	$("#login").click(this.login);
	$("#logout").click(this.logout);
        
        $("button").button();
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

showUserControls: function() {
    var email = $("#user-settings").attr("data-user");
    if(email == "") {
	$("#user-login-box").slideToggle("fast");
    }
    else
	$("#user-settings-box").slideToggle("fast");
},

login: function() {
    var email = $("#email-input").val();
    var password = $("#password-input").val();
    $.ajax({
	url: "/login",
	type:"POST",
	context:this,
	dataType:"json",
	data:{email:email,password:password},
	success:function(json) {
	    if(json.success) {
		$("#user-settings").attr("data-user", json.email);
		$("#user-settings a").html(json.name)
	    }
	    else
		alert("Incorrect E-mail/Password");
	    $("#user-login-box").slideUp("fast");
	}
    });
},

logout: function() {
    $.ajax({
	url: "/logout",
	type:"POST",
	context:this,
    });
    $("#user-settings").attr("data-user", "");
    $("#user-settings a").html("Login")
    $("#user-settings-box").slideUp("fast");
}

});
