var DataRepository = Class.extend({
init:function() {},
fetch:function(unit,depth) {
    // depth is association recursion depth
    if(!depth) depth = 3;
    // Fetch the required unit
},
get:function(type,name) {
    return this[type+"!"+name];
},
remove:function(type,name) {
    // removes the unit and any associations it's linked to
}
});
