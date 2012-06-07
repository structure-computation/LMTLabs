launch_CorreliOnline = ->
    add_modules_to = ( m ) ->
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
        m.modules.push new TreeAppModule_TreeView

    td = new TreeAppData
    td.new_session()
    add_modules_to td
    new TreeApp document.getElementById( 'main_window' ), td
    
#     bs = new BrowserState
#     bs.location.bind ->
#         if bs.location.protocol.get() == 'file:'
#             td = new TreeAppData
#             td.new_session()
#             add_modules_to td
#             new TreeApp document.getElementById( 'main_window' ), td
#         else
#             hash = bs.location.hash.get()
#             if hash.length > 1
#                 path = decodeURIComponent hash.slice 1
#                 FileSystem.get_inst().load path, ( td, err ) ->
#                     new TreeApp document.getElementById( 'main_window' ), td
#             else
#                 hide_windows = ->
#                     document.getElementById('correli_header').style.display = "none"
#                     document.getElementById('main_window').style.display = "none"
#                     
#                 show_windows = ->
#                     document.getElementById('correli_header').style.display = "block"
#                     document.getElementById('main_window').style.display = "block"
#                     
#                 hide_windows()
#                 f = new FileSystem
#                 d = "/home/monkey/sessions"
#                 f.load_or_make_dir d, ( session_dir, err ) ->
#                     div = new_dom_element
#                         parentNode: document.body
# 
#                     item_cp = new ModelEditorItem_Directory
#                         el    : div
#                         model : session_dir
# 
#                     # NEW SESSION
#                     new_dom_element
#                         nodeName: "button"
#                         txt: "New session"
#                         parentNode: div
#                         onclick: ->
#                             div.parentNode.removeChild div
#                             show_windows()
#                             name = "session " + new Date()
#                             
#                             td = new TreeAppData
#                             td.new_session "Session"
#                             add_modules_to td
#                             
#                             session_dir.add_file name, s, model_type: "Session", icon: "session"
#                             window.location = "#" + encodeURI( "#{d}/#{name}" )
#                                 
#                     ModelEditorItem_Directory.add_action "Session", ( file, path, browser ) ->
#                         item_cp.allow_shortkey = false
#                         item_cp = undefined
#                         div.parentNode.removeChild div
#                         show_windows()
#                         
#                         window.location = "#" + encodeURI( path )
#                         #file.load ( model, err ) ->
#                         #    make_TreeApp main_window, ( m ) ->
#                         #        m.add_session model
# 
