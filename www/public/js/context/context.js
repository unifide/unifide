var Context = Class.extend({
init:function(options) {
    this.options = options;
},

name:function(val) {
    if(val) {
        this._name = val;
        this.options.title.text(val);
    } else {
        return this._name;
    }
}
});
