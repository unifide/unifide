/*
 * Renaming action object example
 *
 * app.actions.do({
 *   data:{elem:$("#class_4378"),from:"PrevName",to:"NewName"},
 *   do:function(data) {
 *     data.elem.text(data.to);
 *   },
 *   undo:function(data) {
 *     data.elem.text(data.from);
 *   }
 * });
 */

var ActionStack = Class.extend({
init:function() {
    this.stack = [];
    this.ptr = -1;
},
do:function(action) {
    if(this.stack.length > this.ptr+1) {
        this.stack.splice(this.ptr+1, this.stack.length-this.ptr);
    }
    this.stack.push(action);

    this._redo();
},
undo:function() {
    if(this.canUndo()) {
        this.stack[this.ptr].undo(this.stack[this.ptr].data);
        this.ptr--;
    }
},
redo:function() {
    if(this.canRedo()) {
        this._redo();
    }
},
_redo:function() {
    this.ptr++;
    this.stack[this.ptr].do(this.stack[this.ptr].data);
},
canUndo:function() {
    return this.ptr > -1;
},
canRedo:function() {
    return this.ptr < this.stack.length-1;
}
});
