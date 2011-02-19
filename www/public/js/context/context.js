var Context = Class.extend({
init:function() {
    this.name = "";
    this.children = []; // any child contexts go here
},

name:function(val) {
    if(val) {
        this.name = val;
    }
    else {
        return this.name;
    }
}
});
