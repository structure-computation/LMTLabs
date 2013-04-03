class TreeAppApplication_Scills3D extends TreeAppApplication
    constructor: ->
        super()
         
        @name = 'Scills apps'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
        #scills application 3D
        @actions.push
            ico: "img/scills3D.png"
            txt: "Scills3D"
            ina: _ina
            siz: 1
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                #@add_ass app.data
                scills3D = @add_item_depending_selected_tree app.data, Scills3DItem
        