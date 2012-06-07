launch_CorreliOnline = ->
    new_session = ->
        td = new TreeAppData
        td.new_session()
        
        td.modules.push new TreeAppModule_Session
        td.modules.push new TreeAppModule_File
        td.modules.push new TreeAppModule_UndoManager
        td.modules.push new TreeAppModule_PanelManager
        td.modules.push new TreeAppModule_Correlation
        td.modules.push new TreeAppModule_ImageSet
        td.modules.push new TreeAppModule_Animation
        td.modules.push new TreeAppModule_Mesher
        td.modules.push new TreeAppModule_Sketch
        td.modules.push new TreeAppModule_Transform
        td.modules.push new TreeAppModule_Filter
        td.modules.push new TreeAppModule_ShapeFunction
        td.modules.push new TreeAppModule_MechanicalData
        td.modules.push new TreeAppModule_TreeView
        
        td

    bs = new BrowserState
    bs.location.bind ->
        # file -> make a new session
        if bs.location.protocol.get() == 'file:'
            td = new_session()
            new TreeApp document.body, td
        else
            hash = bs.location.hash.get()
            # something to reload ?
            if hash.length > 1
                path = decodeURIComponent hash.slice 1
                FileSystem.get_inst().load path, ( td, err ) ->
                    new TreeApp document.body, td
                    
            # else, browse old session
            else
                f = new FileSystem
                d = "/home/monkey/sessions"
                f.load_or_make_dir d, ( session_dir, err ) ->
                    div = new_dom_element
                        parentNode: document.body

                    item_cp = new ModelEditorItem_Directory
                        el    : div
                        model : session_dir

                    # NEW SESSION
                    new_dom_element
                        nodeName: "button"
                        txt: "New session"
                        parentNode: div
                        onclick: ->
                            div.parentNode.removeChild div
                            
                            name = "session " + new Date()
                            td = new_session()
                            
                            session_dir.add_file name, td, model_type: "Session", icon: "session"
                            window.location = "#" + encodeURI( "#{d}/#{name}" )

                    # RELOAD
                    ModelEditorItem_Directory.add_action "Session", ( file, path, browser ) ->
                        div.parentNode.removeChild div
                        window.location = "#" + encodeURI( "#{d}/#{file.name.get()}" )
