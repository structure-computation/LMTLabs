#
class BoundariesSelectionItem extends TreeItem
    constructor: ( ) ->
        super()
        
    z_index: ->
        return 1000
    
    accept_child: ( ch ) ->
        ch instanceof PickedZoneItem or
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem
    
    is_app_data: ( item ) ->
        if item instanceof TreeAppData
            return true
        else
            return false
    
    #get app_data
    get_app_data: ->
        #get app_data
        it = @get_parents_that_check @is_app_data
        return it[ 0 ]
        
    
    add_child_mesh : ( msh ) ->
        app_data = @get_app_data()
        if this._children.length <= 0
            just_created = true
        pzi = new PickedZoneItem @_border_type
        @add_child pzi
        ski = new SketchItem
        pzi.add_child ski
        ski.mesh = msh
        
        #close item
        if just_created == true
            path_item = app_data.get_root_path this
            app_data.close_item path_item[ 0 ]
            
        pzi_path = app_data.get_root_path pzi
        app_data.close_item pzi_path[ 0 ]
        
        app_data.watch_item pzi
        
        return pzi
    
    on_mouse_down: ( cm, evt, pos, b ) ->
        if b == "LEFT"
            if cm._flat?
                app_data = @get_app_data()
                best = dist: 10
                for ch in @_children when ch instanceof PickedZoneItem
                    ch.closest_point_closer_than best, cm.cam_info, pos
                    
                    if best.disp? # delete a line in PickedZoneItem
                        app_data.delete_from_tree best.pzi
                        return true
                        
                if not best.disp?
                    # TODO check only parents
                    for msh in cm._flat when msh instanceof Mesh
                        proj = for p in msh.points
                            cm.cam_info.re_2_sc.proj p.pos.get()
                            
                        best = dist: 10
                        for el in msh._elements
                            el.closest_point_closer_than? best, msh, proj, cm.cam_info, pos
                        for el in msh._sub_elements
                            el.closest_point_closer_than? best, msh, proj, cm.cam_info, pos
                        
                        if best.disp?
                            @_may_need_snapshot = true
                            pzi = @add_child_mesh msh
                            pe = mesh : msh, element : best.inst
                            pzi.picked_element.push pe
                                
                return false
                
        return false  

    on_mouse_move: ( cm, evt, pos, b ) ->
        # clear all _pre_selected array
        for ch in @_children when ch instanceof PickedZoneItem
            ch._pelected.clear()
        for msh in cm._flat when msh instanceof Mesh
            msh._pelected_elements.clear()
        
        if cm._flat?
            res = []

            # search to _pre_selecte in priority the already Picked zone
            best = dist: 10
            for ch in @_children when ch instanceof PickedZoneItem
                ch.closest_point_closer_than best, cm.cam_info, pos
                if best.disp?
                    elem = best.inst
                    if elem not in best.pzi._pelected
                        best.pzi._pelected.push elem
                    
                    
            if not best.disp?
                # search _pre_selected in all Meshes
                for msh in cm._flat when msh instanceof Mesh
                    proj = for p in msh.points
                        cm.cam_info.re_2_sc.proj p.pos.get()
                        
                    best = dist: 10
                    for el in msh._elements
                        el.closest_point_closer_than? best, msh, proj, cm.cam_info, pos
                    for el in msh._sub_elements
                        el.closest_point_closer_than? best, msh, proj, cm.cam_info, pos
                        
                    if best.disp? # mean we found something in Mesh
                        elem = best.inst
                        if elem not in msh._pelected_elements
                            msh._pelected_elements.push elem
        return false

#       on_mouse_move: ( cm, evt, pos, b ) ->
#          #clear all _pre_selected array
#         app_data = @get_app_data()
#         session = app_data.selected_session()
#         sketch_child = app_data.get_child_of_type session, SketchItem
#         if sketch_child != false and sketch_child.length > 0
#             for sc in sketch_child
#                 sc.mesh._pelected_points.clear()
#         for ch in @_children when ch instanceof PickedZoneItem
#             ch._pelected_points.clear()
#         
#         if cm._flat?
#             res = []
#             # search to _pre_selecte in priority the already Picked zone
#             for ch in @_children when ch instanceof PickedZoneItem
#                 ch.get_movable_entities res, cm.cam_info, pos, 1, true
#                             
#             if res.length <= 0
#                 # search _pre_selected in all Meshes
#                 for el in cm._flat when el instanceof Mesh
#                     if el.lines?
#                         el.get_movable_entities res, cm.cam_info, pos, 1, true
#                     
#             if res.length
#                 res.sort ( a, b ) -> b.dist - a.dist
#                 @_may_need_snapshot = false
#                 line = res[ 0 ].item[ 0 ]
#                 P0   = res[ 0 ].item[ 1 ]
#                 P1   = res[ 0 ].item[ 2 ]
#                 if res[ 0 ].pzi? # mean we found something in pikcedzonitem
#                     if line not in res[ 0 ].pzi._pelected_points
#                         res[ 0 ].pzi._pelected_points.push line
#                         
#                 else # mean we found something in Mesh
#                     if line not in res[ 0 ].prov._pelected_points
#                         res[ 0 ].prov._pelected_points.push line
#         return false

