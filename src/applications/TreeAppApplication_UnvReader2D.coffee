class TreeAppApplication_UnvReader2D extends TreeAppApplication
    constructor: ->
        super()
         
        @name = 'Scills apps'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
                
        #unv reader application 2D        
        @actions.push
            ico: "img/unv2D.png"
            siz: 1
            txt: "unv reader 2d"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                unv2D = @add_item_depending_selected_tree app.data, UnvReaderItem2D
        