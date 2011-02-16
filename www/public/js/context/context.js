var Context = Class.extend({
init:function(editor, parent) {
    this.editor = editor;
    this.parent = parent;

    this.units = []; // any child contexts go here
    this.top = 0; // the offset from the top for the current context
    this.left = 0; // offset from the left
    this.width = parent.width; // width allocated to the context
    this.height = parent.height; // allocated height
}
});
