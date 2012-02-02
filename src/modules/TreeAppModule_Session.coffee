#
class TreeAppModule_Session extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Session'
        
        @actions.push
            ico: "img/correli.png"
            siz: 2
            txt: "Session information"
            fun: ( evt, app ) ->
                #
                