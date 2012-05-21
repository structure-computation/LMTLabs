
launch_CorreliOnline = ->
    m = new TreeAppData
    m.modules.push new TreeAppModule_Session
    m.modules.push new TreeAppModule_File
    m.modules.push new TreeAppModule_UndoManager
    m.modules.push new TreeAppModule_PanelManager
    m.modules.push new TreeAppModule_Correlation
    m.modules.push new TreeAppModule_ImageSet
    m.modules.push new TreeAppModule_Animation m
    m.modules.push new TreeAppModule_Sketch
    m.modules.push new TreeAppModule_Transform
    m.modules.push new TreeAppModule_Filter
    m.modules.push new TreeAppModule_ShapeFunction
    m.modules.push new TreeAppModule_MechanicalData
    # m.modules.push new TreeAppModule_Photo
    m.modules.push new TreeAppModule_TreeView

    w = document.getElementById "main_window"

    if false
        s = m.new_session name
        new TreeApp w, m
    else
        # make session list (to create or reload a session)
        FileSystem._disp = true
        
        f = new FileSystem
        f.load_or_make_dir "/home/monkey/sessions", ( session_dir, err ) ->
            div = new_dom_element
                parentNode: w
            
            new_dom_element
                txt: "New session"
                parentNode: div
                onclick: ->
                    w.removeChild div
                    name = "session " + new Date()
                    s = m.new_session name
                    session_dir.add_file name, s
                    new TreeApp w, m

            for session in session_dir
                do ( session ) ->
                    new_dom_element
                        txt: session.name.get()
                        parentNode: div
                        onclick: ->
                            w.removeChild div
                            console.log "reload " + session.name.get()
                            session.load ( model, err ) ->
                                m.add_session model
                                new TreeApp w, model
                    
    