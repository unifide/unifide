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
            callback(this._processJSON(json));
        }
    },this));
},
get:function(type,name) {
    return this[type+"!"+name];
},
remove:function(type,name) {
    // removes the unit and any associations it's linked to
    var id = type+"!"+name;
    var u = this[id];
    if(!u) return;

    var isEmpty = function(o) {for(var e in o){return false}return true};

    for(var a in u.assoc) {
        for(var o in u.assoc[a]) {
            var rev = u.assoc[a][o].reverse;
            delete rev[a][id];
            if(isEmpty(rev[a]))
                delete rev[a];
        }
    }
    for(var a in u.reverse) {
        for(var o in u.reverse[a]) {
            var as = u.reverse[a][o].assoc;
            delete as[a][id];
            if(isEmpty(as[a]))
                delete as[a];
        }
    }
    delete this[id];
},
_processJSON:function(json) {
    var map = []; // maps json index to final object
    for(var i=0;i<json.length;i++) {
        var j = json[i];
        var id = j[0]+"!"+j[1]; // Type!Name

        if(!this[id]) { // prepare object if it doesn't exist
            this[id] = {type:j[0],name:j[1],assoc:{},reverse:{}};
        }
        map.push(this[id]);
    }
    for(var i=0;i<json.length;i++) {
        var j = json[i];
        var id = j[0]+"!"+j[1];
        var u = this[id];
        
        for(var a in j[2]) { // a = association name
            var acc = j[2][a]; // acc = association target array
            if(!u.assoc[a]) { // prep for data
                u.assoc[a] = {};
            }
            for(var t=0;t<acc.length;t++) {
                var at = map[acc[t]]; // association target
                u.assoc[a][at.type+"!"+at.name] = at;
                if(!at.reverse[a]) { // prep reverse
                    at.reverse[a] = {};
                }
                at.reverse[a][u.type+"!"+u.name] = u;
            }
        }
    }
    return map[0]; // return the requested unit
}
});