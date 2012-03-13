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
        @actions.push session_info
            
                
        session_info.menu.push 
            ico: "img/.png"
            txt: "Open"
            fun: ( evt, app ) ->
                @model = new File Directory, "LMT"
                
                p = new File ImgItem, "composite01.png"
                ma = new File ImgItem, "masque_0.png"
                d = new File Directory, "Work"
                m = new File Mesh, "Mesh"
                
                @model.data.children.push m
                @model.data.children.push ma
                @model.data.children.push p
                @model.data.children.push d
                
                
                mesh = new File Directory, "Mesh"
                pictures = new File Directory, "Pictures"
                result = new File Directory, "Result"
                d.data.children.push mesh
                d.data.children.push pictures
                d.data.children.push result
                
                
                pic5 = new File ImgItem, "composite05.png"
                pic7 = new File ImgItem, "composite07.png"
                pictures.data.children.push pic5
                pictures.data.children.push pic7
                
                mes1 = new File Mesh, "Mesh"
                mesh.data.children.push mes1
                

                res0 = new File ImgItem, "res_orig.png"
                res1 = new File ImgItem, "res_depX.png"
                res2 = new File ImgItem, "res_depY.png"
                result.data.children.push res0
                result.data.children.push res1
                result.data.children.push res2
                
                @d = new_dom_element
                    className : "browse_container"
                @item_cp = new ModelEditorItem_Directory
                    el    : @d
                    model : @model
                    fundblclick: ( evt, file ) =>
                        if file.data instanceof ImgItem
                            @modules = app.data.modules
                            for m in @modules
                                if m instanceof TreeAppModule_ImageSet
                                    m.actions[ 1 ].fun evt, app, file.data
                                
                        else if file.data instanceof Mesh
                            @modules = app.data.modules
                            for m in @modules 
                                if m instanceof TreeAppModule_Sketch
                                    m.actions[ 0 ].fun evt, app, file.data

                
                    
                p = new_popup "Browse Folder", event : evt, width : 70, child: @d, onclose: =>
                    @onPopupClose( app )
                
                app.active_key.set false
                
            key: [ "Shift+O" ]

            onPopupClose: ( app ) =>
                app.active_key.set true
        
        session_info.menu.push 
            ico: "img/.png"
            txt: "Save"
            fun: ( evt, app ) =>
                #
                console.log "Save"
            key: [ "Ctrl+S" ]
                
        session_info.menu.push 
            ico: "img/.png"
            txt: "Save as"
            fun: ( evt, app ) =>
                #
                console.log "Save as"
            key: [ "Ctrl+Shift+S" ]
                
        session_info.menu.push 
            ico: "img/.png"
            txt: "Export"
            fun: ( evt, app ) =>
                #
                console.log "Export"
                
        session_info.menu.push 
            ico: "img/.png"
            txt: "Log out"
            fun: ( evt, app ) =>
                #
                console.log "Log out"