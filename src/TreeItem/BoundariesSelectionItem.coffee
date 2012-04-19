#
class BoundariesSelectionItem extends TreeItem
    constructor: ( ) ->
        super()
    
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
    
    add_child_mesh : ( res ) ->
        app_data = @get_app_data()
        
        # check if a SKetch Item already exist
        m = app_data.get_child_of_type this, SketchItem
        if m != false and m.length > 0
            return m[ 0 ].mesh
        # else create one PickedZoneItem and SketchItem
        else
            @pzi = new PickedZoneItem
            @add_child @pzi
            @ski = new SketchItem
            @pzi.add_child @ski
            m = @pzi._children[ 0 ].mesh
            
            #close item
            path_item = app_data.get_root_path this
            app_data.close_item path_item[ 0 ]
            
            app_data.watch_item @ski
            return m
            
    on_mouse_down: ( cm, evt, pos, b ) ->
        if b == "LEFT"
            if cm._flat?
                res = []
                app_data = @get_app_data()
#                 own_child_si = app_data.get_child_of_type this, SketchItem
#                 own_child = for own_ch in own_child_si
#                     own_ch.mesh
                for el in cm._flat when el instanceof Mesh
                    if el.lines and el.get_movable_entities?
                        # closest entity under mouse
#                         el.get_movable_entities res, cm.cam_info, pos, el
                        el.get_movable_entities res, cm.cam_info, pos, 1, true
                if res.length
                    res.sort ( a, b ) -> b.dist - a.dist
                    @_may_need_snapshot = true
                    line = res[ 0 ].item[ 0 ]
                    
                    m = @add_child_mesh res
                    
                    line = res[ 0 ].item[ 0 ]
                    if line not in m._selected
                        # need to use ref
                        console.log "line selected"
                        l = m.points.length
                        m.points.push res[ 0 ].item[ 1 ]
                        m.points.push res[ 0 ].item[ 2 ]
                        m.lines.push [ l, l + 1 ]
                        m._selected.push line
                    else
                        console.log "line deleted"
                        ind = m._selected.indexOf line
                        m._selected.splice ind, 1
                        for p in line
                            m.delete_point p.get()
                            
                    return true
                    
        return false
        
    on_mouse_move: ( cm, evt, pos, b ) ->
        if cm._flat?
            res = []
            for el in cm._flat when el instanceof Mesh or el instanceof Border
                if el.lines?
                    # closest entity under mouse
                    el.get_movable_entities res, cm.cam_info, pos, 1, true
                    
        app_data = @get_app_data()
        session = app_data.selected_session()
        sketch_child = app_data.get_child_of_type session, SketchItem
        if sketch_child != false and sketch_child.length > 0
            for sc in sketch_child
                sc.mesh._pre_sele.clear()
            
        if res.length
            res.sort ( a, b ) -> b.dist - a.dist
            
            @_may_need_snapshot = false
            line = res[ 0 ].item[ 0 ]
            P0   = res[ 0 ].item[ 1 ]
            P1   = res[ 0 ].item[ 2 ]
            if line not in res[ 0 ].prov._pre_sele
                res[ 0 ].prov._pre_sele.push line