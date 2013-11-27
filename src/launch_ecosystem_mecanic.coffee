#clear page
MAIN_DIV = document.body
clear_page = ->
    while MAIN_DIV.firstChild?
        MAIN_DIV.removeChild MAIN_DIV.firstChild

#inclusion dans une nouvelle session        
include_standard_session = (td) ->    
    td.applications.push new TreeAppApplication_CRM
    td.applications.push new TreeAppApplication_Annotation
    td.applications.push new TreeAppApplication_Test
    
    
    td.modules.push new TreeAppModule_UndoManager
    td.modules.push new TreeAppModule_PanelManager
    td.modules.push new TreeAppModule_File
    td.modules.push new TreeAppModule_Apps
    #td.modules.push new TreeAppModule_Projects
    td.modules.push new TreeAppModule_TreeView    
        
#inclusion dans une nouvelle session        
include_session = (td) ->    
    td.applications.push new TreeAppApplication_Correlation
    td.applications.push new TreeAppApplication_Scills3D
    td.applications.push new TreeAppApplication_Scult3D
    td.applications.push new TreeAppApplication_Scills2D
    td.applications.push new TreeAppApplication_Scult2D
    #td.applications.push new TreeAppApplication_UnvReader3D
    #td.applications.push new TreeAppApplication_UnvReader2D
    td.applications.push new TreeAppApplication_Mesher
    td.applications.push new TreeAppApplication_Sketcher
    td.applications.push new TreeAppApplication_StepReader
    
    td.applications.push new TreeAppApplication_Plot3D
    td.applications.push new TreeAppApplication_Plot2D
    
    
    #td.applications.push new TreeAppApplication_DeepCopy
    td.applications.push new TreeAppApplication_CsvReader
    td.applications.push new TreeAppApplication_Annotation
    td.applications.push new TreeAppApplication_Scilab
    td.applications.push new TreeAppApplication_Acquisition
    td.applications.push new TreeAppApplication_Test
    
    
    td.modules.push new TreeAppModule_UndoManager
    td.modules.push new TreeAppModule_PanelManager
    td.modules.push new TreeAppModule_File
    td.modules.push new TreeAppModule_Apps
    #td.modules.push new TreeAppModule_Projects
    
    
    td.modules.push new TreeAppModule_Animation
    td.modules.push new TreeAppModule_TreeView    
        
#type de nouvelle session
new_session = ->
    td = new TreeAppData
    td.new_session()
    include_session td
    td
 
new_standard_session = ->
    td = new TreeAppData
    td.new_standard_session()
    include_standard_session td
    td

    
#main program
launch_ecosystem_mecanic = ( main = document.body ) ->
    MAIN_DIV = main

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

                    div_top = new_dom_element
                        parentNode: div
                        style:
                           width: "100%"
                           padding: "10px 20px 10px 20px"
                           height: "50px"
                           #background: "#e5e5e5"
                        
                        
                    # NEW SESSION
                    new_dom_element
                        nodeName: "button"
                        txt: "New scientific project"
                        parentNode: div_top
                        onclick: ( evt ) ->
                            clear_page() 
                            name = prompt "Project name", "project " + new Date()
                            # name = "session " + new Date()
                            td = new_session()
                            
                            session_dir.add_file name, td, model_type: "Session", icon: "session"
                            window.location = "#" + encodeURI( "#{d}/#{name}" )
                    
                    new_dom_element
                        nodeName: "button"
                        txt: "New standard project"
                        parentNode: div_top
                        onclick: ( evt ) ->
                            clear_page() 
                            name = prompt "Project name", "project " + new Date()
                            # name = "session " + new Date()
                            td = new_standard_session()
                            
                            session_dir.add_file name, td, model_type: "Session", icon: "session"
                            window.location = "#" + encodeURI( "#{d}/#{name}" )
                    
                    item_cp = new ModelEditorItem_Directory
                        el             : div
                        model          : session_dir
                        use_icons      : false
                        use_upload     : false
                        use_breadcrumb : false
                        display        : "Session" 

                    

                    # RELOAD
                    ModelEditorItem_Directory.add_action "Session", ( file, path, browser ) ->
                        clear_page()
                        window.location = "#" + encodeURI( "#{d}/#{file.name.get()}" )
