class TreeAppApplication_Plot2D extends TreeAppApplication
    constructor: ->
        super()
        
        @unvreader = ''
        @name = 'Plot'

        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
            
        @actions.push
            ico: "img/plot2D_bouton.png"
            siz: 1
            txt: "function of t"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @unvreader = @add_item_depending_selected_tree app.data, TFunctionItem
                
                
                
        
