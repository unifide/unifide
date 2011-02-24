var UnifideContext = Context.extend({

init:function(editor,parent) {
    this._super(editor,parent);
},

destroy:function() {
    this.elem.remove();
},

resize:function() {
},

draw:function() {
}
});
