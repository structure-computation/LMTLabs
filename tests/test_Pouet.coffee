# lib ../Soja/Soja.js
# lib ../Soja/ModelEditor.js
# lib ../Soja/ModelEditor.css
# lib ../Soja/DomHelper.js
# lib ../Soja/Color.js
# lib ../Soja/Color.css
# lib ../Soja/Geometry.js
# lib ../Soja/BrowserState.js
# lib ../Soja/CanvasManager.js
# lib ../Soja/Animation.js
# lib ../Soja/Theme.js
 
test_Pouet = ->
        
    d = new_dom_element
        parentNode: document.body
        style     : { position: "fixed", top: 0, left: 0 }
        
    c = new CanvasManager
        el: d
        want_aspect_ratio: true
        padding_ratio: 1.4
        constrain_zoom: 'x'
        auto_fit: true
        
    c.cam.threeD.set false
    c.resize 700, 400

    m = new Graph 
        marker: 'dot',
        marker_color: "#f00"
        line_width  : 3,
        line_color: new Color 75, 150, 175
        marker_size: 10,
        x_axis: 'label X',
        y_axis: 'label Y'
        
        
    m.points.push [   0, 12.04, 0 ]
    m.points.push [ 100, 12.8, 0 ]
    m.points.push [ 200, 12.10, 0 ]
    m.points.push [ 255, 12.09, 0 ]
    
    c.items.push m
    c.fit 0
    c.draw()
    g = new_dom_element
        parentNode: document.body
        style     : { position: "fixed", top: 0, left: 800 }
    editor = new_model_editor el: g, model: m, label: "Simple Graph", item_width: 48
    editor.default_types.push ( model ) -> ModelEditorItem_Bool_Img       if model instanceof Bool
    
    new_model_editor el: g, model: c.cam  , label: "cam"  , item_width: 48
    new_model_editor el: g, model: c.theme, label: "theme", item_width: 48
    
    #-------------------
    
    d = new_dom_element
        parentNode: document.body
        style     : { position: "fixed", top: 400, left: 0, width: 700, height: 300 }
        
    c = new CanvasManager el: d, want_aspect_ratio: true, padding_ratio: 1.4, constrain_zoom: 'x'
    c.cam.threeD.set false
    c.resize 700, 300

    # BarChart
    m = new Graph 
        marker: 'bar',
        marker_color: new Color 255, 0, 0
        shadow: false,
        marker_size: 2,
        show_line: false,
        show_grid: false,
        x_axis: 'Day',
        y_axis: 'Rain (mm)'

    m.points.push [   0, 0, 0 ]
    m.points.push [  10, 1.5, 0 ]
    m.points.push [  20, 0.2, 0 ]
    m.points.push [  30, 2.1, 0 ]
    m.points.push [  40, 0.6, 0 ]
    m.points.push [  50, 2, 0 ]
    m.points.push [  60, 0.3, 0 ]
    m.points.push [  70, 1, 0 ]
    m.points.push [  80, 3, 0 ]
    m.points.push [  90, 0.4, 0 ]
    m.points.push [ 100, 1, 0 ]
    m.points.push [ 110, 0.5, 0 ]
    m.points.push [ 120, 0.2, 0 ]
    m.points.push [ 130, 2.6, 0 ]
    m.points.push [ 140, 0.4, 0 ]
    m.points.push [ 150, 2, 0 ]
    m.points.push [ 160, 0.7, 0 ]
    m.points.push [ 170, 1, 0 ]
    m.points.push [ 180, 3, 0 ]
    m.points.push [ 190, 0.4, 0 ]
    m.points.push [ 200, 3, 0 ]
    m.points.push [ 210, 5, 0 ]
    m.points.push [ 220, 2.5, 0 ]
    m.points.push [ 230, 0.9, 0 ]
    m.points.push [ 240, 1.4, 0 ]
    m.points.push [ 250, 2, 0 ]
    
    c.items.push m
    c.fit 0
    c.draw()
