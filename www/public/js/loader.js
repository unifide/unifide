var Loader = Class.extend({
init:function() {
    this.list = {};
},
start:function(key,label) {
    this.list[key] = label;
},
end:function(key) {
    delete this.list[key];
    if(this.empty() && this.callback) {
        this.callback();
    }
},
onLoad:function(callback) {
    this.callback = callback;
    if(this.empty()) {
        this.callback();
    }
},
empty:function() {
    for(var i in this.list) return false;
    return true;
}
});
