var Context = Class.extend({
state:{}, // our current state
widget:null, // the widget is the context's view
init:function(opts) {}
});

var ProjectContext = Context.extend({
init:function(opts) {
    this._super(opts);
}
});
