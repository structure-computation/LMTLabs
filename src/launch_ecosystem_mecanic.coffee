launch_ecosystem_mecanic = ( main = document.body ) ->
    new_session = ->
        td = new TreeAppData
        td.new_session()
        
        td.applications.push new TreeAppApplication_Correlation
        td.applications.push new TreeAppApplication_Scills3D
        td.applications.push new TreeAppApplication_Scills2D
        td.applications.push new TreeAppApplication_Scult3D
        td.applications.push new TreeAppApplication_Scult2D
        td.applications.push new TreeAppApplication_UnvReader3D
        td.applications.push new TreeAppApplication_UnvReader2D
        td.applications.push new TreeAppApplication_Mesher
        td.applications.push new TreeAppApplication_Plot2D
        td.applications.push new TreeAppApplication_Plot3D
        td.applications.push new TreeAppApplication_DeepCopy
        td.applications.push new TreeAppApplication_CsvReader
        
        
        td.modules.push new TreeAppModule_UndoManager
        td.modules.push new TreeAppModule_File
        td.modules.push new TreeAppModule_Apps
        td.modules.push new TreeAppModule_PanelManager
        td.modules.push new TreeAppModule_Animation
        td.modules.push new TreeAppModule_TreeView
       
        #td.modules.clear()
        #td.modules.concat td.base_modules
       
#         td.modules.push new TreeAppModule_Mesher
#         td.modules.push new TreeAppModule_Sketch
#         td.modules.push new TreeAppModule_Transform
#         td.modules.push new TreeAppModule_Animation
#         td.modules.push new TreeAppModule_Compute

        

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
            
        else
            
            hash = bs.location.hash.get()
            # something to reload ?
            if hash.length > 1
                clear_page()
                path = decodeURIComponent hash.slice 1
                fs.load path, ( td, err ) ->
                    if err
                        window.location = "#"
                    else
                        app = new TreeApp main, td
                            
                        # visualisation
                        fs.load_or_make_dir "/sessions/" + fs._session_num, ( session_dir, err ) ->
                            session_dir.add_file "server_assisted_visualization", new ServerAssistedVisualization app, bs
                    
            # else, browse old session
            else
                if !SC_MODEL_ID? or SC_MODEL_ID == -1
                  d = "/home/monkey/sessions"
                else
                  d = "/home/projet_" + SC_MODEL_ID
                fs.load_or_make_dir d, ( session_dir, err ) ->
                    clear_page()
                    
                    div = new_dom_element
                        parentNode: main

                    item_cp = new ModelEditorItem_Directory
                        el             : div
                        model          : session_dir
                        use_icons      : true
                        use_upload     : true
                        use_breadcrumb : true

                    # NEW SESSION
                    new_dom_element
                        nodeName: "button"
                        txt: "New session"
                        parentNode: div
                        onclick: ( evt ) ->
                            clear_page()
                            
                            name = prompt "Session name", "session " + new Date()
                            # name = "session " + new Date()
                            td = new_session()
                            
                            session_dir.add_file name, td, model_type: "Session", icon: "session"
                            window.location = "#" + encodeURI( "#{d}/#{name}" )
                            
                            
                            #FIXME Is it necessary to create a new treeapp here ?
#                             app = new TreeApp main, td
#                             for correlation in td.modules when correlation instanceof TreeAppModule_Correlation
#                                 correlation.actions[ 0 ].fun( evt, app )

                    # RELOAD
                    ModelEditorItem_Directory.add_action "Session", ( file, path, browser ) ->
                        clear_page()
                        window.location = "#" + encodeURI( "#{d}/#{file.name.get()}" )
