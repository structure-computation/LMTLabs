#
class TreeAppModule_MechanicalData extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Mechanical Data'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id and 
            app.data.focus.get() != app.treeview.view_id
            
        @actions.push
            ico: "img/mechanical_tools.png"
            siz: 2
            ina: _ina
            txt: "Configure comportemental law"
            fun: ( evt, app ) ->
                console.log "comportemental law"
                
#             key: [ "Shift+L" ]

        @actions.push
            ico: "img/border_constrain.png"
            siz: 1
            ina: _ina
            txt: "Constrain a border"
            fun: ( evt, app ) ->
                console.log "now select a constrain border"
                app.selected_canvas_inst()?[ 0 ]?.cm.add_point_on_line.toggle()
                app.selected_canvas_inst()?[ 0 ]?.cm.draw() #TODO we should avoid using draw cause onchange method should be call with previous line
                app.undo_manager.snapshot()

            key: [ "Shift+G" ]
            
        @actions.push
            ico: "img/border_free.png"
            siz: 1
            ina: _ina
            txt: "Make a border out of any constrain"
            fun: ( evt, app ) ->
                console.log "now select a free border"
                app.selected_canvas_inst()?[ 0 ]?.cm.add_point_on_line.toggle()
                app.selected_canvas_inst()?[ 0 ]?.cm.draw()
                app.undo_manager.snapshot()

            key: [ "Shift+F" ]
            