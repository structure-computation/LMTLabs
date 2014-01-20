class TreeAppApplication_Scult3D extends TreeAppApplication
    constructor: ->
        super()
         
        @name = 'Mesh partition 3D'
        @powered_with    = 'SC'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
        #scult application 3D
        @actions.push
            ico: "img/scult3D_bouton.png"
            siz: 1
            txt: "Scult 3d"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                scult3D = @add_item_depending_selected_tree app.data, Scult3DItem
                
        