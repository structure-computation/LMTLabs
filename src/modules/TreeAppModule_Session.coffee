#
class TreeAppModule_Session extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Session'
        
        session_info =
            ico: "img/correli.png"
            siz: 2
            txt: "Session information"
            sub:
                prf: "menu"
                act: [ ]
                
            key: [ "Esc" ]

        @actions.push session_info
            
        test1 =
            ico: "img/correli.png"
            txt: "E"
            fun: ( evt, app ) =>
                #
                console.log "E"
            key: [ "Ctrl+Alt+E" ]
        test2 =
            ico: "img/correli.png"
            txt: "R"
            fun: ( evt, app ) =>
                #
                console.log "R"
            key: [ "Ctrl+Alt+R" ]
            
        session_info.sub.act.push 
            ico: ""
            txt: "Open"
            fun: ( evt, app ) ->
                @modules = app.data.modules
                for m in @modules
                    if m instanceof TreeAppModule_File
                        m.actions[ 0 ].fun evt, app
                    
            
            
        session_info.sub.act.push 
            ico: ""
            txt: "Save"
            fun: ( evt, app ) =>
                #
                console.log "Save"
            key: [ "Ctrl+S" ]
            #testing recursivity
            sub:
                prf: "menu"
                act: [test1, test2 ]
                
        session_info.sub.act.push 
            ico: ""
            txt: "Save as"
            fun: ( evt, app ) =>
                #
                console.log "Save as"
            key: [ "Ctrl+Shift+S" ]
                
        session_info.sub.act.push 
            ico: ""
            txt: "Export"
            fun: ( evt, app ) =>
                #
                console.log "Export"
            key: [ "Ctrl+E" ]
                
        session_info.sub.act.push 
            ico: ""
            txt: "Log out"
            fun: ( evt, app ) =>
                #
                console.log "Log out"
            key: [ "Ctrl+L" ]