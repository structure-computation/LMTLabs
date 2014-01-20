class TreeAppApplication_Scult2D extends TreeAppApplication
    constructor: ->
        super()
         
        @name = 'Mesh partition 2D'
        @powered_with    = 'SC'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
    
        #scult application 2D
        @actions.push
            ico: "img/scult2D_bouton.png"
            siz: 1
            txt: "Scult 2d"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                scult2D = @add_item_depending_selected_tree app.data, Scult2DItem
        