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
            
        test1 =
            mod: new Str "name"
            sub:
                prf: "list"
                act: [ ]
            key: [ "Ctrl+Alt+T" ]
        test2 =
            txt: "PNG"
            fun: ( evt, app ) =>
                #
                console.log "PNG"
            key: [ "Ctrl+Alt+R" ]
            
        test3 =
            txt: "PDF"
            siz: 1
            fun: ( evt, app ) =>
                #
                console.log "PDF"
            key: [ "Ctrl+Alt+E" ]
#                 
        session_info.sub.act.push
            txt: "Save as"
            fun: ( evt, app ) =>
                #
                console.log "Save as"
            key: [ "Ctrl+Shift+S" ]
            #testing recursivity
            sub:
                prf: "menu"
                act: [test1, test2, test3 ]
                
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