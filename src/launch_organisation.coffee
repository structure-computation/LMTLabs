#clear page
USER_EMAIL = ""

APPS = new Lst

load_if_cookie_organisation = () ->
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
                    #launch_ecosystem_mecanic user_id, decodeURIComponent lst[ 1 ].trim()
                    launch_organisation user_id, decodeURIComponent lst[ 1 ].trim()
                else
                    window.location = "login.html" 
                    
                
        xhr_object.send()
    
    else   
        window.location = "login.html" 
              
        
        
launch_organisation = ( userid, home_dir, main = document.body ) ->
    MAIN_DIV = main
    
    #load or create config file
    FileSystem._home_dir = home_dir
    FileSystem._userid   = userid
    bs = new BrowserState
    fs = new FileSystem
    config_dir = FileSystem._home_dir + "/__config__" 
    
    fs.load_or_make_dir config_dir, ( current_dir, err ) ->
        config_file = current_dir.detect ( x ) -> x.name.get() == ".config"
        if not config_file?
            alert "no config !"
            window.location = "desk.html"  
        else
            config_file.load ( config, err ) =>
                create_organisation_view config, main

                 
    
create_organisation_view = ( config, main = document.body ) ->

    #ajout des applications de EcosystemMecanics    
    APPS.push new TreeAppApplication_Correlation
    APPS.push new TreeAppApplication_DicUncertainty
    APPS.push new TreeAppApplication_Scills3D
    APPS.push new TreeAppApplication_Scult3D
    APPS.push new TreeAppApplication_Scills2D
    APPS.push new TreeAppApplication_Scult2D
    APPS.push new TreeAppApplication_FieldsComparator
    APPS.push new TreeAppApplication_FieldExport
    APPS.push new TreeAppApplication_VirtualGauge
    APPS.push new TreeAppApplication_AbaqusComputation
    APPS.push new TreeAppApplication_Code_Aster_Computation
    APPS.push new TreeAppApplication_IdentificationWithAbaqus
    APPS.push new TreeAppApplication_IdentificationWithCode_Aster
    APPS.push new TreeAppApplication_Mesher
    #APPS.push new TreeAppApplication_Sketcher
    APPS.push new TreeAppApplication_StepReader  
#     APPS.push new TreeAppApplication_StepReaderToNurbs
    APPS.push new TreeAppApplication_Plot3D
    APPS.push new TreeAppApplication_Plot2D
    #APPS.push new TreeAppApplication_DeepCopy
    APPS.push new TreeAppApplication_CsvReader
    APPS.push new TreeAppApplication_Annotation
    APPS.push new TreeAppApplication_TestA
    
    #login bar
    login_bar = new LoginBar main, config
    
    #desk organisation
    organisation_data = new OrganisationData config
    organisation_desk = new OrganisationView main, organisation_data
    
    
#     layout = new LayoutManagerData
#               sep_norm: 0
#               children: [ 
#                       {
#                           sep_norm: 1
#                           children: [
#                               {
#                                 panel_id: "DeskListView"
#                                 immortal: true
#                               }, {
#                                 panel_id: "MessageListView"
#                                 immortal: true
#                               }
#                           ]
#                                   
#                       }, {
#                           panel_id: "DeskNavigatorView"
#                           strength: 3,
#                       } 
#               ]
#         
#         
#     container_global = new_dom_element
#         id : "organisation_container"
#         parentNode : main
#         style:
#             position: "absolute"
#             left    : 0
#             right   : 0
#             top     : "32px"
#             bottom  : 0
#             
#             
#     lm = new LayoutManager container_global, layout
#     lm.show()
    
    
  
    
    
    
    

    
    


