#
class TreeAppModule_Session extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Session'
        
        session_info =
            ico: "img/correli.png"
            siz: 2
            txt: "Session information"
            fun: ( evt, app ) ->
                menu_container = document.getElementsByClassName("menu_container")[ 0 ]
                menu_container.classList.toggle "block"
                
                #
            menu:[ ]
            key: [ "Esc" ]
        @actions.push session_info
            
                
        session_info.menu.push 
            ico: ""
            txt: "Open"
            fun: ( evt, app ) ->
                @modules = app.data.modules
                for m in @modules
                    if m instanceof TreeAppModule_File
                        m.actions[ 0 ].fun evt, app
        
        session_info.menu.push 
            ico: ""
            txt: "Save"
            fun: ( evt, app ) =>
                #
                console.log "Save"
            key: [ "Ctrl+S" ]
                
        session_info.menu.push 
            ico: ""
            txt: "Save as"
            fun: ( evt, app ) =>
                #
                console.log "Save as"
            key: [ "Ctrl+Shift+S" ]
                
        session_info.menu.push 
            ico: ""
            txt: "Export"
            fun: ( evt, app ) =>
                #
                console.log "Export"
            key: [ "Ctrl+E" ]
                
        session_info.menu.push 
            ico: ""
            txt: "Log out"
            fun: ( evt, app ) =>
                #
                console.log "Log out"
            key: [ "Ctrl+L" ]