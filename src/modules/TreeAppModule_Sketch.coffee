class TreeAppModule_Sketch extends TreeAppModule
    constructor: ->
        super()
        
        sketch = ''
        
        @name = 'Sketch'

        _ina_cm = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id and 
            app.data.focus.get() != app.treeview.view_id
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
        @actions.push
            ico: "img/curve.png"
            siz: 1
            txt: "Transform line to curve"
            ina: _ina_cm
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                cam_info = app.selected_canvas_inst()[ 0 ].cm.cam_info
                @sketch.mesh.make_curve_line_from_selected( cam_info )
            key: [ "Shift+C" ]
        
        @actions.push
            ico: "img/cube3d_32.png"
            siz: 1
            txt: "ref"
            ina: _ina
            fun: ( evt, app ) =>
                @sketch = @add_item_depending_selected_tree app, SketchItem
                @sketch.mesh.move_scheme = MoveScheme_3D
                load_croix @sketch.mesh
                for p in @sketch.mesh.displayed_field.lst[ 1 ]._data
                    p.set( - p.get() )
                
                
        @actions.push
            ico: "img/break.png"
            siz: 1
            txt: "Break curve to line"
            ina: _ina_cm
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                cam_info = app.selected_canvas_inst()[ 0 ].cm.cam_info
                @sketch.mesh.break_line_from_selected( cam_info )
            key: [ "Shift+B" ]
        
        
        @actions.push
            ico: "img/cube3d_32.png"
            siz: 1
            txt: "Create complex 3D shape"
            ina: _ina_cm
            fun: ( evt, app ) =>
                #
                app.undo_manager.snapshot()
                @sketch = @add_item_depending_selected_tree app, SketchItem
                @sketch.mesh.move_scheme = MoveScheme_3D

                mesh = @sketch.mesh
                load_truc_3d mesh
                
                mesh.editable_points.set false
                mesh.displayed_style.set "Wireframe"
                
                #                 xhr_object = Synchronizer.my_xml_http_request()
                #                 xhr_object.open "GET", "carter.js", true
                #                 xhr_object.onreadystatechange = =>
                #                     if xhr_object.readyState == 4 && xhr_object.status == 200
                #                         eval xhr_object.responseText
                #                 xhr_object.send ""
                
                #                 currentPoint = @sketch.mesh.points.length
                # 
                #                 pos = [
                #                     [ 0, 0, 0 ],
                #                     [ 0, 0, 1 ],
                #                     [ 0, 1, 0 ],
                #                     [ 0, 1, 1 ],
                #                     [ 1, 0, 0 ],
                #                     [ 1, 0, 1 ],
                #                     [ 1, 1, 0 ],
                #                     [ 1, 1, 1 ],
                #                 ]
                #                 
                #                 for coord in pos
                #                     @sketch.mesh.add_point coord
                #                 
                #                 @sketch.mesh.lines.push [ currentPoint, currentPoint + 1 ]
                #                 @sketch.mesh.lines.push [ currentPoint, currentPoint + 2 ]
                #                 @sketch.mesh.lines.push [ currentPoint + 1, currentPoint + 3 ]
                #                 @sketch.mesh.lines.push [ currentPoint + 3, currentPoint + 2 ]
                #                 @sketch.mesh.lines.push [ currentPoint + 4, currentPoint + 5 ]
                #                 @sketch.mesh.lines.push [ currentPoint + 5, currentPoint + 7 ]
                #                 @sketch.mesh.lines.push [ currentPoint + 7, currentPoint + 6 ]
                #                 @sketch.mesh.lines.push [ currentPoint + 6, currentPoint + 4 ]
                #                 @sketch.mesh.lines.push [ currentPoint, currentPoint + 4 ]
                #                 @sketch.mesh.lines.push [ currentPoint + 1, currentPoint + 5 ]
                #                 @sketch.mesh.lines.push [ currentPoint + 2, currentPoint + 6 ]
                #                 @sketch.mesh.lines.push [ currentPoint + 3, currentPoint + 7 ]
                
                app.fit()
                
            key: [ "Shift+T" ]

        
                    
        mesher_sub =
            ico: "img/shape.png"
            siz: 1
            txt: "Create Shape"
            ina: _ina_cm
            sub:
                prf: "list"
                act: [ ]
            key: [ "M" ]
        @actions.push mesher_sub
        
        mesher_sub.sub.act.push 
            ico: "img/shape.png"
            siz: 1
            txt: "Create a Square"
            ina: _ina_cm
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @create_mesher app
                        
                @sketch = @add_item_depending_selected_tree app, SketchItem
                
                @sketch.mesh.move_scheme = MoveScheme_2D
                current_point = @sketch.mesh.points.length
                
                for coord in [ [ -0.33, -0.333 ], [ 0.33, -0.333 ], [ 0.33, 0.333 ], [ -0.33, 0.333 ] ]
                    point = app.selected_canvas_inst()[ 0 ].cm.cam.get_screen_coord coord
                    @sketch.mesh.add_point point
                
                current_line = @sketch.mesh.lines.length
                @sketch.mesh.lines.push [ current_point, current_point + 1 ]
                @sketch.mesh.lines.push [ current_point + 1, current_point + 2 ]
                @sketch.mesh.lines.push [ current_point + 2, current_point + 3 ]
                @sketch.mesh.lines.push [ current_point + 3, current_point ]
                
                @sketch.mesh.polygons.push [ current_line, current_line + 1, current_line + 2, current_line + 3 ]
                @sketch.mesh.displayed_style.set "Wireframe"
                
        
        mesher_sub.sub.act.push 
            ico: "img/circle.png"
            siz: 1
            txt: "Create a Circle edge"
            ina: _ina_cm
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @create_mesher app

                @sketch = @add_item_depending_selected_tree app, SketchItem
                    
                current_point = @sketch.mesh.points.length
                
                for coord in [ [ -0.33, 0 ], [ 0, 0.33 ], [ 0.33, 0 ] ]
                    point = app.selected_canvas_inst()[ 0 ].cm.cam.get_screen_coord coord
                    @sketch.mesh.add_point point
                    
                current_line = @sketch.mesh.lines.length
                @sketch.mesh.lines.push [ current_point, current_point + 1, current_point + 2, current_point ]
                @sketch.mesh.polygons.push [ current_line ]
                @sketch.mesh.displayed_style.set "Wireframe"
                
        mesher_sub.sub.act.push 
            ico: "img/triangle.png"
            siz: 1
            txt: "Create a Triangle edge"
            ina: _ina_cm
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @create_mesher app

                @sketch = @add_item_depending_selected_tree app, SketchItem
                    
                current_point = @sketch.mesh.points.length
                
                for coord in [ [ 0, 0.33 ], [ -0.33, -0.333 ], [ 0.33, -0.333 ] ]
                    point = app.selected_canvas_inst()[ 0 ].cm.cam.get_screen_coord coord
                    @sketch.mesh.add_point point
                    
                current_line = @sketch.mesh.lines.length
                @sketch.mesh.lines.push [ current_point, current_point + 1 ]
                @sketch.mesh.lines.push [ current_point + 1, current_point + 2 ]
                @sketch.mesh.lines.push [ current_point + 2, current_point ]
                @sketch.mesh.polygons.push [ current_line, current_line + 1, current_line + 2 ]
                @sketch.mesh.displayed_style.set "Wireframe"
                
        
        @actions.push
            ico: "img/deletePoint_24.png"
            siz: 1
            txt: "Delete Point"
            ina: _ina
            fun: ( evt, app ) =>
                if @sketch?
                    app.undo_manager.snapshot()
                    cam_info = app.selected_canvas_inst()[ 0 ].cm.cam_info
                    @sketch.mesh.delete_selected_point( cam_info )
                    
            key: [ "Del" ]
            
    create_mesher: ( app ) =>
        create_mesher = true
        discret = false
        for it in app.data.get_selected_tree_items() when it instanceof DiscretizationItem
            discret = true
            if it._children.length > 0
                for ch in it._children
                    if ch instanceof MesherItem
                        create_mesher = false
                        
        if discret == false
            create_mesher = false
            
        if create_mesher == true
            @add_item_depending_selected_tree app, MesherItem
