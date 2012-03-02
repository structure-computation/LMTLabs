#
class TreeAppModule_ShapeFunction extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Shape Function'
        
        @actions.push
            ico: "img/shape_function.png"
            siz: 2
            txt: "Use shape function"
            fun: ( evt, app ) =>                
                shape_function = @add_item_depending_selected_tree app, ShapeFunctionItem
                
                app.undo_manager.snapshot()
            key: [ "Shift+F" ]
