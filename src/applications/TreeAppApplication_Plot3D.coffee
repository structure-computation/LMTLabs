class TreeAppApplication_Plot3D extends TreeAppApplication
    constructor: ->
        super()
        
        @name = 'Plot surface'
        @powered_with    = 'SC'

        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
                
        @actions.push
            ico: "img/plot3D_bouton.png"
            siz: 1
            txt: "function of (x,y)"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                plot3D = @add_item_depending_selected_tree app.data, SurfaceFunctionItem
                
                
        
