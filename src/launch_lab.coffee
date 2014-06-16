# #clear page
# MAIN_DIV = document.body
# USER_EMAIL = ""
# APPS = new Lst
# 
# clear_page = ->
#     while MAIN_DIV.firstChild?
#         MAIN_DIV.removeChild MAIN_DIV.firstChild
# 
#     
# load_if_cookie_lab = () ->
#     if $.cookie("email") and $.cookie("password")
#         email = $.cookie("email")
#         password = $.cookie("password")
#         USER_EMAIL = email
#         
#         xhr_object = FileSystem._my_xml_http_request()
#         xhr_object.open 'GET', "get_user_id?u=#{encodeURI email}&p=#{encodeURI password}", true
#         xhr_object.onreadystatechange = ->
#             if @readyState == 4 and @status == 200
#                 lst = @responseText.split " "
#                 user_id = parseInt lst[ 0 ]
#                 if user_id > 0
#                     launch_lab user_id, decodeURIComponent lst[ 1 ].trim()
#                 else
#                      window.location = "login.html"     
#                     
#                 
#         xhr_object.send()
#           
#     else   
#         window.location = "login.html"       
#     
# 
# #main program
# launch_lab = ( userid, home_dir, main = document.body ) ->
#     FileSystem._home_dir = home_dir
#     FileSystem._userid   = userid
#     MAIN_DIV = main
#     
#     #ajout des applications de EcosystemMecanics
#     APPS.push new TreeAppApplication_Correlation
#     APPS.push new TreeAppApplication_Scills3D
#     APPS.push new TreeAppApplication_Scult3D
#     APPS.push new TreeAppApplication_Scills2D
#     APPS.push new TreeAppApplication_Scult2D
#     APPS.push new TreeAppApplication_FieldsComparator
#     #APPS.push new TreeAppApplication_UnvReader3D
#     #APPS.push new TreeAppApplication_UnvReader2D
#     APPS.push new TreeAppApplication_Mesher
#     APPS.push new TreeAppApplication_Sketcher
#     APPS.push new TreeAppApplication_StepReader  
#     APPS.push new TreeAppApplication_Plot3D
#     APPS.push new TreeAppApplication_Plot2D
#     #APPS.push new TreeAppApplication_DeepCopy
#     APPS.push new TreeAppApplication_CsvReader
#     APPS.push new TreeAppApplication_Annotation
#     APPS.push new TreeAppApplication_Scilab
#     APPS.push new TreeAppApplication_Acquisition
#     APPS.push new TreeAppApplication_Grid
#     APPS.push new TreeAppApplication_Test
#         
#     
#     fs = new FileSystem
#     #lab
#     config_dir = FileSystem._home_dir + "/__config__" 
#     
#     fs.load_or_make_dir config_dir, ( current_dir, err ) ->
#         config_file = current_dir.detect ( x ) -> x.name.get() == ".config"
#         if not config_file?
#             alert "problem"
# 
#         else
#             config_file.load ( config, err ) =>
#                 create_lab_view config, main
# 
#                 
# create_lab_view = ( config, main = document.body ) ->
#     #login bar
#     bs = new BrowserState
#     fs = new FileSystem
#                   
#         
#     #login bar
#     login_bar = new LoginBar main, config
#     
#     # file -> make a new session
#     hash = bs.location.hash.get()
#     # something to reload ?
#     if hash.length > 1
#         path = decodeURIComponent hash.slice 1
#         fs.load path, ( td, err ) ->
#             if err
#                 window.location = "#"
#             else
#                 app = new TreeApp main, td, config
#                     
#                 # visualisation
#                 fs.load_or_make_dir "/sessions/" + fs._session_num, ( session_dir, err ) ->
#                     session_dir.add_file "server_assisted_visualization", new ServerAssistedVisualization app, bs
#                 
#     # else, return to desk
#     else
#         window.location = "desk.html"


#clear page
MAIN_DIV = document.body
USER_EMAIL = ""
APPS = new Lst

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

    
load_if_cookie_lab = () ->
    if $.cookie("email") and $.cookie("password")
        email = $.cookie("email")
        password = $.cookie("password")
        USER_EMAIL = email
        
        xhr_object = FileSystem._my_xml_http_request()
        xhr_object.open 'GET', "get_user_id?u=#{encodeURI email}&p=#{encodeURI password}", true
        xhr_object.onreadystatechange = ->
            if @readyState == 4 and @status == 200
                lst = @responseText.split " "
                user_id = parseInt lst[ 0 ]
                if user_id > 0
                    launch_lab user_id, decodeURIComponent lst[ 1 ].trim()
                else
                     window.location = "login.html"     
                    
                
        xhr_object.send()
          
    else   
        window.location = "login.html"       
    

#main program
launch_lab = ( userid, home_dir, main = document.body ) ->
    FileSystem._home_dir = home_dir
    FileSystem._userid   = userid
    MAIN_DIV = main
    
       
    
    #lab
    bs = new BrowserState
    fs = new FileSystem
    
    bs.location.bind ->
        clear_page()

        
        #login bar
        config_dir = FileSystem._home_dir + "/__config__" 
        fs.load_or_make_dir config_dir, ( current_dir, err ) ->
            config_file = current_dir.detect ( x ) -> x.name.get() == ".config"
            config_file.load ( config, err ) =>
                login_bar = new LoginBar main, config

        hash = bs.location.hash.get()
        # something to reload ?
        if hash.length > 1
            path = decodeURIComponent hash.slice 1
            fs.load path, ( td, err ) ->
                if err
                    window.location = "#"
                else
                    app = new TreeApp main, td
                        
                    # visualisation
                    fs.load_or_make_dir "/sessions/" + fs._session_num, ( session_dir, err ) ->
                        session_dir.add_file "server_assisted_visualization", new ServerAssistedVisualization app, bs
                
        # else, return to desk
        else
            window.location = "desk.html"