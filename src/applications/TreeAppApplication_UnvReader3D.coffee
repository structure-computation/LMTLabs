class TreeAppApplication_UnvReader3D extends TreeAppApplication
    constructor: ->
        super()
         
        @name = 'Scills apps'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
        
        #unv reader application 3D   
        @actions.push
            ico: "img/unv3D.png"
            siz: 1
            txt: "unv reader 3d"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                unv3D = @add_item_depending_selected_tree app.data, UnvReaderItem3D
        