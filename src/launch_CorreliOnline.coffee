
launch_CorreliOnline = ->
    m = new TreeAppData
    m.modules.push new TreeAppModule_PanelManager
    m.modules.push new TreeAppModule_UndoManager
    m.modules.push new TreeAppModule_Sketch
    m.modules.push new TreeAppModule_Correlation
    m.modules.push new TreeAppModule_Transform
    m.modules.push new TreeAppModule_ImageSet
    m.modules.push new TreeAppModule_Photo
    
    m.new_session "LMT"
    
    s = m.selected_session()
    # s._children.push new ImgItem "../data/1007.png"
    
    v = new TreeApp document.getElementById( "main_window" ), m        
    