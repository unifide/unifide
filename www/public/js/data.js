var DataRepository = Class.extend({
init:function() {},
fetch:function(type,name,callback,depth,force) {
    // return if we have it already, unless forcing
    if(this["default:"+type+":"+name] && !force) return this["default:"+type+":"+name];
    // depth is association recursion depth
    if(!depth) depth = 1;
    // Fetch the required unit
    $.ajax({
        url:"units/default/"+type+"/"+name,
        type:"GET",
        context:this,
        dataType:"json",
        data:{depth:depth},
        error:function(e, xhr) {
            if(xhr == "parsererror") {
                console.error("Error parsing JSON");
            } else {
                console.error("Error fetching Data from server");
            }
        },
        success:function(json) {
            if(!json.success) {
                console.error("Error fetching JSON: "+json.error);
            } else {
                callback(this._processJSON(json,'default',type,name));
            }
        }
    });
},
get:function(type,name) {
    return this[type+":"+name];
},
remove:function(type,name) {
    // removes the unit and any associations it's linked to
    var id = "default:"+type+":"+name;
    var u = this[id];
    if(!u) return;

    var isEmpty = function(o) {for(var e in o){return false}return true};

    for(var a in u.assoc) {
        for(var o in u.assoc[a]) {
            var rev = u.assoc[a][o].reverse;
            delete rev[a][id];
            if(isEmpty(rev[a])) {
                delete rev[a];
                // handle autosave
            }
        }
    }
    for(var a in u.reverse) {
        for(var o in u.reverse[a]) {
            var as = u.reverse[a][o].assoc;
            delete as[a][id];
            if(isEmpty(as[a])) {
                delete as[a];
                // handle autosave
            }
        }
    }
    delete this[id];
    // handle autosave
},
_processJSON:function(json,project,type,name) {
    var map = {}; // maps json index to final object

    // write units to memory
    for(var p in json.units) {
	var types = json.units[p];
	for(var t in types) {
	    var units = types[t];
	    for(var u in units) {
		var unit = units[u];
		var i = unit[0];
		var nom = unit[1];
		var id = p+":"+t+":"+nom; // project:type:name
		if(!this[id]) { // prepare object if it doesn't exist
		    this[id] = new Unit(p,t,nom);
		}
		map[i] = this[id];
	    }
	}
    }

    // apply associations
    for(var p in json.units) {
	var types = json.units[p];
	for(var t in types) {
	    var units = types[t];
	    for(var j=0;j<units.length;j++) {
		var unit = units[j];
		var i = unit[0];
		var nom = unit[1];
		var id = p+":"+t+":"+nom; // project:type:name
		realUnit = this[id];
		for(var at in unit[2]) {
		    var as = unit[2][at]; // list of association targets
		    for(var k=0;k<as.length;k++) {
			realUnit.addAssociation(at,map[as[k]]);
		    }
		}
	    }
	}
    }

    // update depths
    var root = this[project+":"+type+":"+name];
    this._updateDepth(root,json.depth);

    return root; // return the requested unit
},
_updateDepth:function(unit, depth) {
    if(depth < 0 || unit.depth >= depth) return;

    unit.depth = depth;
    for(var a in unit.assoc) {
        for(var o in unit.assoc[a]) {
            var next = unit.assoc[a][o];
            this._updateDepth(next,depth-1);
        }
    }
}
});

var Unit = Class.extend({
init:function(project,type,name) {
    this.type = type;
    this.name = name;
    this.project = project;
},
addAssociation:function(assoc_type,target) {
    var hasType = "has"+assoc_type;
    if(!this[hasType]) {
        this[hasType] = new Association(hasType);
    }
    this[hasType].add(target);

    var isType = "is"+assoc_type+"Of";
    if(!target[isType]) {
        target[isType] = new Association(isType);
    }
    target[isType].add(this);
},
remove:function() {
}
});

var Association = Class.extend({
init:function(type) {
    this.type = type;
    this.data = {};
},
add:function(unit) {
    this.data[unit.type+":"+unit.name] = unit;
},
// First argument can either be a type or a callback
// Second argument must be callback
// Arguments are optional
each:function(arg, callback) {
    var type = null;
    switch(typeof arg) {
        case "function":
            callback = arg;
            break;
        case "string":
            type = arg;
            break;
    }
    var output = new AssociationSet();
    for(var u in this.data) {
        var unit = this.data[u];
        if(!type || type == unit.type) {
            output.add(unit);
            if(callback) {
                callback(unit);
            }
        }
    }
    return output;
},
get:function(type,name) {
    if(type && name) {
        // return directly if type and name defined
        return this.data[type+":"+name];
    } else if(type) {
        // return first of type if type declared
        for(var u in this.data) {
            if(this.data[u].type == type) {
                return this.data[u];
            }
        }
    } else {
        // return first item if nothing declared
        for(var u in this.data) {
            return this.data[u];
        }
    }
},
names:function() {
    var list = [];
    for(var u in this.data) {
        list.push(this.data[u].name);
    }
    return $.unique(list);
},
types:function() {
    var list = [];
    for(var u in this.data) {
        list.push(this.data[u].type);
    }
    return $.unique(list);
},
units:function() {
    var list = [];
    for(var u in this.data) {
        list.push(this.data[u]);
    }
    return $.unique(list);
}
});

var AssociationSet = Class.extend({
init:function() {},
add:function(unit) {
    for(var type in unit) {
        if(type.match(/^has.*/) || type.match(/^is.*Of$/)) {
            if(!this[type]) {
                this[type] = new Association(type);
            }
            for(var subId in unit[type].data) {
                var subUnit = unit[type].data[subId];
                this[type].add(subUnit);
            }
        }
    }
}
});
