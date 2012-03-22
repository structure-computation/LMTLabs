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
                
#             key: [ "Shift+Z" ]

        @actions.push
            ico: "img/border_constrain.png"
            siz: 1
            ina: _ina
            txt: "Constrain a border"
            fun: ( evt, app ) ->
                console.log "now select a constrain border"

            key: [ "Shift+G" ]
            
        @actions.push
            ico: "img/border_free.png"
            siz: 1
            ina: _ina
            txt: "Make a border out of any constrain"
            fun: ( evt, app ) ->
                console.log "now select a free border"

            key: [ "Shift+F" ]
            