class TreeAppApplication_IpolLsd extends TreeAppApplication
    constructor: ->
        super()
        
        @name = 'Line Segment Detector'
        @powered_with = 'Ipol'

        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
            
        @actions.push
            ico: "img/ipolLsd_bouton.png"
            siz: 1
            txt: "Ipol LSD"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                ipolLsd = @add_item_depending_selected_tree app.data, IpolLsdItem

