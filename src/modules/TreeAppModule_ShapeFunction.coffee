#
class TreeAppModule_ShapeFunction extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Shape Function'
        
        @actions.push
            ico: "img/shape_function.png"
            siz: 2
            txt: "Use shape function"
            fun: ( evt, app ) ->
                console.log "shape function"
                
#             key: [ "Shift+Z" ]
