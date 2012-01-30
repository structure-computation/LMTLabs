
launch_CorreliOnline = ->
    m = new TreeAppData
    m.modules.push new TreeAppModule_File
    m.modules.push new TreeAppModule_UndoManager
    m.modules.push new TreeAppModule_PanelManager
    m.modules.push new TreeAppModule_Correlation
    m.modules.push new TreeAppModule_ImageSet
    m.modules.push new TreeAppModule_Animation
    m.modules.push new TreeAppModule_Sketch
    m.modules.push new TreeAppModule_Transform
    m.modules.push new TreeAppModule_Filter
    m.modules.push new TreeAppModule_ShapeFunction
    m.modules.push new TreeAppModule_MechanicalData
#     m.modules.push new TreeAppModule_Photo
    m.modules.push new TreeAppModule_TreeView
    
    m.new_session "LMT"
    
    s = m.selected_session()
    
    v = new TreeApp document.getElementById( "main_window" ), m        
    