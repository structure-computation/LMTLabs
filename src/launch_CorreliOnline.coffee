
launch_CorreliOnline = ->
    m = new TreeAppData
    m.modules.push new TreeAppModule_PanelManager
    m.modules.push new TreeAppModule_UndoManager 
    m.modules.push new TreeAppModule_Sketch
    m.new_session "Session 1"
    
    s = m.selected_session()
    s._children.push new ImgItem "/home/leclerc/0062_001-0.png"
    
    v = new TreeApp document.getElementById( "main_window" ), m
    