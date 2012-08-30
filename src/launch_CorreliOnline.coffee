launch_CorreliOnline = ( main = document.body ) ->
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
        td.modules.push new TreeAppModule_Compute
        td.modules.push new TreeAppModule_TreeView
        
        
        td
        
    clear_page = ->
        while main.firstChild?
            main.removeChild main.firstChild


    bs = new BrowserState
    fs = new FileSystem
    # FileSystem._disp = true
    
    bs.location.bind ->
        # file -> make a new session
        if bs.location.protocol.get() == 'file:'
            td = new_session()
            app = new TreeApp main, td
            for correlation in td.modules when correlation instanceof TreeAppModule_Correlation
                correlation.actions[ 0 ].fun( '', app )
        else
            hash = bs.location.hash.get()
            # something to reload ?
            if hash.length > 1
                clear_page()
                path = decodeURIComponent hash.slice 1
                FileSystem.get_inst().load path, ( td, err ) ->
                    if err
                        window.location = "#"
                    else
                        new TreeApp main, td
                    
            # else, browse old session
            else
                d = "/home/monkey/sessions"
                fs.load_or_make_dir d, ( session_dir, err ) ->
                    clear_page()
                    
                    div = new_dom_element
                        parentNode: main

                    item_cp = new ModelEditorItem_Directory
                        el             : div
                        model          : session_dir
                        use_icons      : true
                        use_upload     : false
                        use_breadcrumb : true

                    # NEW SESSION
                    new_dom_element
                        nodeName: "button"
                        txt: "New session"
                        parentNode: div
                        onclick: ( evt ) ->
                            clear_page()
                            
                            name = "session " + new Date()
                            td = new_session()
                            
                            session_dir.add_file name, td, model_type: "Session", icon: "session"
                            window.location = "#" + encodeURI( "#{d}/#{name}" )
                            
                            #FIXME Is it necessary to create a new treeapp here ?
                            app = new TreeApp main, td
                            for correlation in td.modules when correlation instanceof TreeAppModule_Correlation
                                correlation.actions[ 0 ].fun( evt, app )

                    # RELOAD
                    ModelEditorItem_Directory.add_action "Session", ( file, path, browser ) ->
                        clear_page()
                        window.location = "#" + encodeURI( "#{d}/#{file.name.get()}" )
