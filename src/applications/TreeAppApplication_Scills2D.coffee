class TreeAppApplication_Scills2D extends TreeAppApplication
    constructor: ->
        super()
         
        @name = 'Structure simulation'
        @powered_with    = 'SC'
        @company         = 'Structure Computation'
        @link            = ""     
        @group           = "scills"
        @key_words       = ["structure"," analisys", "LATIN", "mechanic"]
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
         #scills application 2D
        @actions.push
            ico: "img/scills2D_bouton.png"
            txt: "Scills2D"
            ina: _ina
            siz: 1
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                #@add_ass app.data
                Scills2D = @add_item_depending_selected_tree app.data, Scills2DItem
        