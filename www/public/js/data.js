var DataRepository = Class.extend({
init:function() {},
fetch:function(type,name,callback,depth,force) {
    // return if we have it already, unless forcing
    if(this[type+"!"+name] && !force);
    // depth is association recursion depth
    if(!depth) depth = 3;
    // Fetch the required unit
    $.post("/json/"+type+"/"+name+"/"+depth,$.proxy(function(json) {
        if(json.error) {
            console.error("Error fetching JSON: "+json.error);
        } else {
            callback(json);
        }
    },this));
},
get:function(type,name) {
    return this[type+"!"+name];
},
remove:function(type,name) {
    // removes the unit and any associations it's linked to
}
});
