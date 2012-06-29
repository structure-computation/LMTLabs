class TreeAppModule_Sketch extends TreeAppModule
    constructor: ->
        super()
                
        @name = 'Sketch'

        _ina_cm = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id and 
            app.data.focus.get() != app.treeview.view_id
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
        _ctx_act = ( act ) =>
            if act.sub?
                return false
            else
                return true

        #         @actions.push
        #             ico: "img/curve.png"
        #             siz: 1
        #             txt: "ex triangles"
        #             ina: _ina_cm
        #             ctx: _ctx_act
        #             fun: ( evt, app ) =>
        #                 app.undo_manager.snapshot()
        #                 
        #                 
        #                 #----
        #                 
        #                 el = new Element_TriangleList
        #                 el.indices.resize [ 1, 3 ]
        #                 el.indices.set_val [ 0, 0 ], 0
        #                 el.indices.set_val [ 0, 1 ], 1
        #                 el.indices.set_val [ 0, 2 ], 2
        #                 
        #                 mesh = new Mesh
        #                 mesh.add_point [ 0, 0, 0 ]
        #                 mesh.add_point [ 1, 0, 0 ]
        #                 mesh.add_point [ 0, 1, 0 ]
        #                 mesh.add_element el
        #                 
        #                 nf = new NodalField mesh
        #                 nf._data.set_val 0, 0
        #                 nf._data.set_val 1, 1
        #                 nf._data.set_val 2, 2
        #                 
        #                 #                 it = new FieldItem "toto", nf
        #                 #                 @watch_item app, it
        #                 #                 app.data.tree_items.push it
        #                 
        #                 item =
        #                     pos  :
        #                         axe_name : "time"
        #                         axe_value: 0
        #                     field    : nf
        #                         
        #                 interpolated_field.data.push item
        #                 
        #                 #----
        #                 
        #                 
        #                 el = new Element_TriangleList
        #                 el.indices.resize [ 1, 3 ]
        #                 el.indices.set_val [ 0, 0 ], 0
        #                 el.indices.set_val [ 0, 1 ], 2
        #                 el.indices.set_val [ 0, 2 ], 1
        #                 
        #                 mesh = new Mesh
        #                 mesh.add_point [ 0, 0, 0 ]
        #                 mesh.add_point [ 1.1, 0, 0 ]
        #                 mesh.add_point [ 0, 1.1, 0 ]
        #                 mesh.add_element el
        #                 
        #                 nf = new NodalField mesh
        #                 nf._data.set_val 0, 0
        #                 nf._data.set_val 1, 1
        #                 nf._data.set_val 2, 2
        #                 
        #                 #                 it_bis = new FieldItem "toto bis", nf
        #                 #                 @watch_item app, it_bis
        #                 #                 app.data.tree_items.push it_bis                
        #                 #                 
        #                 item_bis =
        #                     pos  :
        #                         axe_name : "time"
        #                         axe_value: 2
        #                         field    : nf
        #                         
        #                 interpolated_field.data.push item_bis
        #                 
        #                 #----
        #                 
        #                 imf = new ImageField "test_pic", "img/curve.png"
        #                 #                 it_ter = new FieldItem "picture", imf
        #                 #                 @watch_item app, it_ter
        #                 #                 app.data.tree_items.push it_ter
        # 
        #                 item_ter =
        #                     pos  :
        #                         axe_name : "time"
        #                         axe_value: 0
        #                         field    : imf
        #                         
        #                 interpolated_field.data.push item_ter

        @actions.push
            ico: "img/curve.png"
            siz: 1
            txt: "Transform line to curve"
            ina: _ina_cm
            ctx: _ctx_act
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                for it in app.data.get_selected_tree_items() when it instanceof SketchItem
                    if it.mesh?
                        it.mesh.make_curve_line_from_selected()
            key: [ "Shift+C" ]
        
        @actions.push
            ico: "img/cube3d_32.png"
            siz: 1
            txt: "ref"
            ina: _ina
            ctx: _ctx_act
            fun: ( evt, app ) =>
                sketch = @add_item_depending_selected_tree app, SketchItem
                sketch.mesh.move_scheme = MoveScheme_3D
                load_croix sketch.mesh
                for p in sketch.mesh.display_field.lst[ 1 ]._data
                    p.set( - p.get() )
                
                
        @actions.push
            ico: "img/break.png"
            siz: 1
            txt: "Break curve to line"
            ina: _ina_cm
            ctx: _ctx_act
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                for it in app.data.get_selected_tree_items() when it instanceof SketchItem
                    if it.mesh?
                        it.mesh.break_line_from_selected()
            key: [ "Shift+B" ]
        
        
        @actions.push
            ico: "img/cube3d_32.png"
            siz: 1
            txt: "Create a sample complex 3D shape"
            ina: _ina_cm
            ctx: _ctx_act
            fun: ( evt, app ) =>
                #
                app.undo_manager.snapshot()
                sketch = @add_item_depending_selected_tree app, SketchItem
                sketch.mesh.move_scheme = MoveScheme_3D

                mesh = sketch.mesh
                load_truc_3d mesh
                
                mesh.visualization.display_style.set "Wireframe"
                mesh.visualization.point_edition.set false
                
                app.fit()
                
            key: [ "Shift+T" ]

        
                    
        mesher_sub =
            ico: "img/shape.png"
            siz: 1
            txt: "Create Shape"
            ina: _ina_cm
            ctx: _ctx_act
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
            ctx: _ctx_act
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @create_mesher app # TODO: ca n'a pas grand chose a faire la !!
                        
                sketch = @add_item_depending_selected_tree app, SketchItem
                sketch.mesh.visualization.display_style.set "Wireframe"
                sketch.mesh.move_scheme = new MoveScheme_2D
                
                current_point = sketch.mesh.points.length
                for coord in [ [ -0.333, -0.333 ], [ 0.333, -0.333 ], [ 0.333, 0.333 ], [ -0.333, 0.333 ] ]
                    point = app.selected_canvas_inst()[ 0 ].cm.cam.get_screen_coord coord
                    sketch.mesh.add_point point
                
                sketch.mesh.add_element new Element_BoundedSurf [
                    { o: +1, e: new Element_Line [ current_point + 0, current_point + 1 ] }
                    { o: +1, e: new Element_Line [ current_point + 1, current_point + 2 ] }
                    { o: +1, e: new Element_Line [ current_point + 2, current_point + 3 ] }
                    { o: +1, e: new Element_Line [ current_point + 3, current_point + 0 ] }
                ]
                
        
        mesher_sub.sub.act.push 
            ico: "img/circle.png"
            siz: 1
            txt: "Create a Circle edge"
            ina: _ina_cm
            ctx: _ctx_act
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @create_mesher app

                sketch = @add_item_depending_selected_tree app, SketchItem
                    
                current_point = sketch.mesh.points.length
                
                for coord in [ [ -0.33, 0 ], [ 0, 0.33 ], [ 0.33, 0 ] ]
                    point = app.selected_canvas_inst()[ 0 ].cm.cam.get_screen_coord coord
                    sketch.mesh.add_point point
                    
                sketch.mesh.add_element new Element_BoundedSurf [
                    { o: +1, e: new Element_Arc [ current_point + 0, current_point + 1, current_point + 2, current_point + 0 ] }
                ]
                sketch.mesh.visualization.display_style.set "Wireframe"
                
        mesher_sub.sub.act.push 
            ico: "img/triangle.png"
            siz: 1
            txt: "Create a Triangle edge"
            ina: _ina_cm
            ctx: _ctx_act
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @create_mesher app

                sketch = @add_item_depending_selected_tree app, SketchItem
                    
                current_point = sketch.mesh.points.length
                
                for coord in [ [ 0, 0.33 ], [ -0.33, -0.333 ], [ 0.33, -0.333 ] ]
                    point = app.selected_canvas_inst()[ 0 ].cm.cam.get_screen_coord coord
                    sketch.mesh.add_point point
                    
                sketch.mesh.add_element new Element_BoundedSurf [
                    { o: +1, e: new Element_Line [ current_point + 0, current_point + 1 ] }
                    { o: +1, e: new Element_Line [ current_point + 1, current_point + 2 ] }
                    { o: +1, e: new Element_Line [ current_point + 2, current_point + 0 ] }
                ]
                sketch.mesh.visualization.display_style.set "Wireframe"
                
        
        @actions.push
            ico: "img/deletePoint_24.png"
            siz: 1
            txt: "Delete Point"
            ina: _ina
            ctx: _ctx_act
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                cam_info = app.selected_canvas_inst()[ 0 ].cm.cam_info                    
                for it in app.data.get_selected_tree_items() when it instanceof SketchItem
                    if it.mesh?
                        it.mesh.delete_selected_point cam_info
                        
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
