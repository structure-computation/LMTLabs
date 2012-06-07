make_TreeApp = ( w, f, load_modules = true ) ->
    m = new TreeAppData
    if load_modules
        m.modules.push new TreeAppModule_Session
        m.modules.push new TreeAppModule_File
        m.modules.push new TreeAppModule_UndoManager
        m.modules.push new TreeAppModule_PanelManager
        m.modules.push new TreeAppModule_Correlation
        m.modules.push new TreeAppModule_ImageSet
        m.modules.push new TreeAppModule_Animation m
        m.modules.push new TreeAppModule_Mesher
        m.modules.push new TreeAppModule_Sketch
        m.modules.push new TreeAppModule_Transform
        m.modules.push new TreeAppModule_Filter
        m.modules.push new TreeAppModule_ShapeFunction
        m.modules.push new TreeAppModule_MechanicalData
        m.modules.push new TreeAppModule_Compute
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
    
    if location.protocol == 'file:'
        show_windows()
        
        make_TreeApp main_window, ( m ) ->
            m.new_session "Session"
    else
        # make session list (to create or reload a session)
        # FileSystem._disp = true
        
        f = new FileSystem
        d = "/home/monkey/sessions"
        f.load_or_make_dir d, ( session_dir, err ) ->
            div = new_dom_element
                parentNode: w

            item_cp = new ModelEditorItem_Directory
                el    : div
                model : session_dir

            # NEW SESSION
            new_dom_element
                nodeName: "button"
                txt: "New session"
                parentNode: div
                onclick: ->
                    w.removeChild div
                    show_windows()
                    name = "session " + new Date()
                    # window.location = "#" + encodeURI( "#{d}/#{name}" )
                    make_TreeApp main_window, ( m ) ->
                        item_cp.allow_shortkey = false
                        item_cp = undefined
                        s = m.new_session name
                        session_dir.add_file name, s, model_type: "Session", icon: "session"
                        
            ModelEditorItem_Directory.add_action "Session", ( file, path, browser ) ->
                item_cp.allow_shortkey = false
                item_cp = undefined
                w.removeChild div
                show_windows()
                file.load ( model, err ) ->
                    make_TreeApp main_window, ( m ) ->
                        m.add_session model

