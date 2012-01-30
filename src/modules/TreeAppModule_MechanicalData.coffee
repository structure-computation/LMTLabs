#
class TreeAppModule_MechanicalData extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Mechanical Data'
        
        @actions.push
            ico: "img/mechanical_tools.png"
            siz: 2
            txt: "Configure comportemental law"
            fun: ( evt, app ) ->
                console.log "comportemental law"
                
#             key: [ "Shift+Z" ]

        @actions.push
            ico: "img/border_constrain.png"
            siz: 1
            txt: "Constrain a border"
            fun: ( evt, app ) ->
                console.log "now select a constrain border"

            key: [ "Shift+G" ]
            
        @actions.push
            ico: "img/border_free.png"
            siz: 1
            txt: "Make a border out of any constrain"
            fun: ( evt, app ) ->
                console.log "now select a free border"

            key: [ "Shift+F" ]
            