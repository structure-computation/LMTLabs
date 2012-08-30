#
class TreeAppModule_ShapeFunction extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Shape Function'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id and 
            app.data.focus.get() != app.treeview.view_id
            
        @actions.push
            ico: "img/shape_function.png"
            siz: 2
            ina: _ina
            txt: "Use shape function"
            fun: ( evt, app ) =>                
                app.undo_manager.snapshot()
                shape_function = @add_item_depending_selected_tree app.data, ShapeFunctionItem
            key: [ "Shift+F" ]
