#
class BoundariesSelectionItem extends TreeItem
    constructor: ( ) ->
        super()
    
    add_picked_zone : ->
        @pzi = @add_child PickedZoneItem
        console.log @pzi
    
        
    on_mouse_down: ( cm, evt, pos, b ) ->
        if b == "LEFT"
            if cm._flat?
                res = []
                for el in cm._flat when el instanceof Mesh or el instanceof Border
                    if el.lines?
                        # closest entity under mouse
                        @get_movable_entities res, cm.cam_info, pos, el
                if res.length
                    res.sort ( a, b ) -> b.dist - a.dist
                    @_may_need_snapshot = true
                    line = res[ 0 ].item[ 0 ]
                    if @pzi?
                        @add_picked_zone()
#                     if line not in @_selected
#                         console.log "line founded"
#                         @_selected.push line
#                         l = @points.length
#                         
#                         #We could bind P0 pos to actual mesh (so if mesh move, P0 will move too)
#                         P0   = res[ 0 ].item[ 1 ]
#                         P1   = res[ 0 ].item[ 2 ]
#                         
#                         @points.push P0
#                         @points.push P1
#                         @lines.push [ l, l + 1 ]
#                     else
#                         console.log "line deleted"
#                         ind = @_selected.indexOf line
#                         @_selected.splice ind, 1
#                         #TODO delete line (code is in mesh.coffee)
                    
                    return true
                    
        return false
        
#     on_mouse_move: ( cm, evt, pos, b ) ->
#         @_pre_sele.clear()
#         if cm._flat?
#             res = []
#             for el in cm._flat when el instanceof Mesh or el instanceof Border
#                 if el.lines?
#                     # closest entity under mouse
#                     @get_movable_entities res, cm.cam_info, pos, el
#         if res.length
#             res.sort ( a, b ) -> b.dist - a.dist
#             @_may_need_snapshot = false
#             line = res[ 0 ].item[ 0 ]
#             P0   = res[ 0 ].item[ 1 ]
#             P1   = res[ 0 ].item[ 2 ]
#             if line not in @_pre_sele
#                 @_pre_sele.push line
#                 # should call onchange method
                
                
    get_movable_entities: ( res, info, pos, el ) ->
        x = pos[ 0 ]
        y = pos[ 1 ]
        proj = for p in el.points
            info.re_2_sc.proj p.pos.get()
            
        for li, i in el.lines when li.length == 2
            P0 = el.lines[ i ][ 0 ].get()
            P1 = el.lines[ i ][ 1 ].get()
            
            point = @_get_line_inter proj, P0, P1, x, y, el
            if point?
                res.push
                    item: [ el.lines[ i ], el.points[ P0 ], el.points[ P1 ] ]
                    dist: 0
                    type: "Mesh"
                break
    
    _get_line_inter: ( proj, P0, P1, x, y, el ) ->
        lg_0 = P0
        lg_1 = P1
        
        a = proj[ lg_0 ]
        b = proj[ lg_1 ]
        
        if a[ 0 ] != b[ 0 ] or a[ 1 ] != b[ 1 ]
            dx = b[ 0 ] - a[ 0 ]
            dy = b[ 1 ] - a[ 1 ]
            px = x - a[ 0 ]
            py = y - a[ 1 ]
            l = dx * dx + dy * dy
            d = px * dx + py * dy
            if d >= 0 and d <= l
                px = a[ 0 ] + dx * d / l
                py = a[ 1 ] + dy * d / l
                if Math.pow( px - x, 2 ) + Math.pow( py - y, 2 ) <= 4 * 4
                    dx = el.points[ lg_1 ].pos[ 0 ].get() - el.points[ lg_0 ].pos[ 0 ].get()
                    dy = el.points[ lg_1 ].pos[ 1 ].get() - el.points[ lg_0 ].pos[ 1 ].get()
                    dz = el.points[ lg_1 ].pos[ 2 ].get() - el.points[ lg_0 ].pos[ 2 ].get()
                    
                    return [ dx, dy, dz, d / l ]