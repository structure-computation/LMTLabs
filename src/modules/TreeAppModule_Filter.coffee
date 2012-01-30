#
class TreeAppModule_Filter extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Filter'
        
        @actions.push
            ico: "img/material_selection.png"
            siz: 1
            txt: "Select part of material"
            fun: ( evt, app ) ->
                console.log "material selection"
            key: [ "Shift+Z" ]
            

            