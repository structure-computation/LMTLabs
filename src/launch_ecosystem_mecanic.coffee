#convertir une array en json string
array2json = ( arr ) -> 
    parts = []
    is_list = (Object.prototype.toString.apply(arr) == '[object Array]')
    is_list2 = (Object.prototype.toString.apply(arr) == '[object Object]')
    virgule ='on'

    for key in arr
        value = arr[key]
        if(typeof value == "object") #Custom handling for arrays
            str = ""
            str2 = ""
            #alert('object_' + key)
            if is_list2
                str =  '\"' + key + '\":'
                virgule = 'on'
                str2 = array2json(value) #/* :RECURSION: */
                str += str2
                #str = '{' + str + '}'
                parts.push(str)
            else if is_list
                if isNaN(key)
                    str =  '\"' + key + '\":'
                    virgule ='on'
                    str2 = array2json(value) # /* :RECURSION: */
                    str += str2
                    #str = '{' + str + '}'
                    parts.push(str)
                else
                    virgule ='off'
                    parts.push(array2json(value)) #/* :RECURSION: */
            else
                parts[key] = array2json(value) # /* :RECURSION: */

            #else parts.push('"' + key + '":' + returnedVal);
        else
            if typeof value != "function"
                #virgule ='on';
                str = ""
                #if(!is_list) 
                str =  '\"' + key + '\":'
    
                #Custom handling for multiple data types
                if typeof value == "number"
                    str += value #Numbers
                else if value == false  
                    str += 'false' #The booleans
                else if value == true 
                    str += 'true'
                else 
                    str +=  '\"' + value + '\"' #All other things
                # :TODO: Is there any more datatype we should be in the lookout for? (Functions?)
                parts.push(str)

                
    if virgule =='on'
      json = parts.join(", ")
      return '{' + json + '}' #Return numerical JSON

    else if virgule =='off'
      json = parts.join(", ")
      return '[' + json + ']' #Return associative JSON
    
    #if(is_list) return '{' + json + '}';//Return numerical JSON
    #return '{' + json + '}';//Return associative JSON







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
                        txt: "New session"
                        parentNode: div_top
                        onclick: ( evt ) ->
                            clear_page() 
                            name = prompt "Session name", "session " + new Date()
                            # name = "session " + new Date()
                            td = new_session()
                            
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
