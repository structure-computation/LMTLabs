class TreeAppModule_Transform extends TreeAppModule
    constructor: ->
        super()
        
        transf = ''
        
        @name = 'Transformation'
        
        @actions.push
            ico: "img/transform_48.png"
            siz: 2
            txt: "Start making transformation"
            fun: ( evt, app ) =>
                #
                selected_items = app.data.get_selected_tree_items()
                @transf = @add_item_depending_selected_tree app, TransformItem
                @child_in_selected app, TransformItem, selected_items
                app.undo_manager.snapshot()
                
                
        @actions.push
            ico: "img/node_add_24.png"
            siz: 1
            txt: "Add a transformation node"
            fun: ( evt, app ) =>
                canvas = app.selected_canvas_inst()[ 0 ].div
                #if we click on ico
                if evt.clientY < get_top( canvas )
                    p = [ 0, 0, 0 ]
                else
                    pos_x = evt.clientX - get_left( canvas )
                    pos_y = evt.clientY - get_top ( canvas )
                    p = app.selected_canvas_inst()[ 0 ].cm.cam_info.sc_2_rw.pos pos_x, pos_y
                 

                selected_items = app.data.get_selected_tree_items()
                @transf = @add_item_depending_selected_tree app, TransformItem
                @child_in_selected app, TransformItem, selected_items
                
                # inverse transform position for origin (old_point)
                trans = [ 0, 0, 0 ]
                p_cur = p
                if @transf.transform.cur_points.length >= 1
                    trans = Vec_3.sub @transf.transform.cur_points[ 0 ].pos, @transf.transform.old_points[ 0 ].pos
                    p_cur = Vec_3.sub p, trans
                    
                @transf.transform.cur_points.push p
                @transf.transform.old_points.push p_cur
                
                app.undo_manager.snapshot()
        
        @actions.push
            ico: "img/node_del_24.png"
            siz: 1
            txt: "Remove a transformation node"
            fun: ( evt, app ) =>
            
                if @transf?
                    cam_info = app.selected_canvas_inst()[ 0 ].cm.cam_info
                    
                    if @transf.transform.cur_points.length > 0
                        selectedPoint = []
                        for i in [ 0 ... @transf.transform.cur_points.length ]
                            if cam_info.selected[ @transf.transform.cur_points[ i ].model_id ]?
                                selectedPoint.push i
                                
                        if selectedPoint.length > 0
                            for i in [ selectedPoint.length-1..0 ]                    
                                @transf.transform.cur_points.splice( selectedPoint[ i ], 1 )
                                @transf.transform.old_points.splice( selectedPoint[ i ], 1 )
                                app.undo_manager.snapshot()
