make_TreeApp = ( w, f ) ->
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
    m.modules.push new TreeAppModule_TreeView

    f m
    new TreeApp w, m

    
hide_windows = ->
    document.getElementById('correli_header').style.display = "none"
    document.getElementById('main_window').style.display = "none"
     
show_windows = ->
    document.getElementById('correli_header').style.display = "block"
    document.getElementById('main_window').style.display = "block"
       
launch_CorreliOnline = ->
    hide_windows()
    w = document.getElementsByTagName("body")[ 0 ]
    
    main_window = document.getElementById('main_window')
    
    if false
        make_TreeApp main_window, ( m ) -> m.new_session "Session"
    else
        # make session list (to create or reload a session)
        # FileSystem._disp = true
        
        f = new FileSystem
        f.load_or_make_dir "/home/monkey/sessions", ( session_dir, err ) ->
        
            div = new_dom_element
                parentNode: w

            
            # NEW SESSION
            new_dom_element
                txt: "New session"
                parentNode: div
                onclick: ->
                    w.removeChild div
                    show_windows()
                    name = "session " + new Date()
                    make_TreeApp main_window, ( m ) ->
                        s = m.new_session name
                        session_dir.add_file name, s, model_type: "Session", icon: "session"
                        
            console.log session_dir
            item_cp = new ModelEditorItem_Directory
                                    el    : div
                                    model : session_dir
#             session_dir.info.model_type = "Session"
                                    
            ModelEditorItem_Directory.add_action "Session", ( file, path, browser ) ->
                console.log "open session"
                show_windows()
                w.removeChild div
                session.load ( model, err ) ->
                    make_TreeApp main_window, ( m ) ->
                        s = m.add_session model


            # OLD OnE
            for session in session_dir
                do ( session ) ->
                    new_dom_element
                        txt: session.name.get()
                        parentNode: div
                        onclick: ->
                            w.removeChild div
                            show_windows()
                            session.load ( model, err ) ->
                                make_TreeApp main_window, ( m ) ->
                                   s = m.add_session model

