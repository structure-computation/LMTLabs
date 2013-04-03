class TreeAppApplication_Scilab extends TreeAppApplication
    constructor: ->
        super()
        
        @mesher = ''
        @name = 'Scilab'

        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
            
        @actions.push
            ico: "img/scilab.png"
            siz: 1
            txt: "Scilab"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @mesher = @add_item_depending_selected_tree app.data, ScilabItem
        
            key: [ "Shift+M" ]

        
            