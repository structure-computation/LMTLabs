class TreeAppApplication_Mesher extends TreeAppApplication
    constructor: ->
        super()
        
        @name = 'Mesh generation'
        @powered_with    = 'GMSH'

        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
            
        @actions.push
            ico: "img/mesher_bouton.png"
            siz: 1
            txt: "Gmsh"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                mesher = @add_item_depending_selected_tree app.data, GmshItem
        
            key: [ "Shift+M" ]

        
            