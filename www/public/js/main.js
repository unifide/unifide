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
        $("#registration-menu-item a").click(function() {$("#registration-box").dialog("open")});
        $("#settings-box").mouseleave(function() { $("#settings-box").slideUp("fast"); });
	// if statement is due to a bug in Chrome 9
        $("#user-login-box").mouseleave(function() { if(event.target==this)$("#user-login-box").slideUp("fast"); });
        $("#user-settings-box").mouseleave(function() { $("#user-settings-box").slideUp("fast"); });
        $("#theme-toggle").click(this.toggleTheme);
	$("#login").click(this.login);
	$("#logout").click(this.logout);
    
	$("#registration-box").dialog({
	    autoOpen:false,
	    modal:true, 
	    title:"Registration",
	    buttons: {"Register": this.register}
	});
	var email = $("#user-settings").attr("data-user");
	if(email != "") {
	    $("#registration-menu-item").hide();
	}
        
        $("button").button();
	$(".tool").draggable({revert:true,containment:$("#editor"),opacity:0.5,cursor:"hand"}).addClass("ui-corner-all");

	this.updateProjects();
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
	$("#login-username").val("username");
	$("#login-password").val("password");
    }
    else
	$("#user-settings-box").slideToggle("fast");
},

login: function() {
    var username = $("#login-username").val();
    var password = $("#login-password").val();
    $.ajax({
	url: "/login",
	type:"POST",
	context:this,
	dataType:"json",
	data:{username:username,password:password},
	success:function(json) {
	    if(json.success) {
		$("#user-settings").attr("data-user", json.email);
		var userMenu = $("#user-settings a");
		userMenu.html(json.username);
		$("#registration-menu-item").hide();
		app.updateProjects();
	    }
	    else
		alert("Incorrect Username/Password");
	    $("#user-login-box").slideUp("fast");
	}
    });
},

logout: function() {
    $.ajax({
	url: "/logout",
	type:"POST",
	context:this,
	success:function() {
	    app.updateProjects();
	    $("#user-settings").attr("data-user", "");
	    $("#user-settings a").html("Login")
	    $("#user-settings-box").slideUp("fast");
	    $("#registration-menu-item").show();
	}
    });
},

register: function() {
    var firstName = $("#reg-fname").val();
    var secondName = $("#reg-sname").val();
    var username = $("#reg-username").val();
    var email = $("#reg-email").val();
    var password = $("#reg-password").val();
    var confirmPassword = $("#reg-password-confirm").val();
    $.ajax({
	url:"/register",
	type:"POST",
	context:this,
	dataType:"json",
	data:{first_name:firstName,second_name:secondName,username:username,email:email,password:password},
	success:function(json) {
	    if(json.success) {
		$("#user-settings").attr("data-user", json.email);
		$("#user-settings a").html(json.name);
		$("#registration-menu-item").hide();
		$(this).dialog("close");
	    }
	}
    });
}
});
