#
class BorderConstrainItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Constrain border"
        @_ico.set "img/border_constrain_16.png"
        @_viewable.set true
        
        # behavior
        @_selected = new Lst # references of selected points / lines / ...
        
    accept_child: ( ch ) ->
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem
        
    sub_canvas_items: ->
        [  ]

    
    on_mouse_down: ( cm, evt, pos, b ) ->
        delete @_movable_entity
        if b == "LEFT"
            if cm._flat?
                for el in cm._flat when el instanceof Mesh
                    if el.lines?
                        # closest entity under mouse
                        res = []
                        @get_movable_entities res, cm.cam_info, pos, el
                        if res.length
                            res.sort ( a, b ) -> b.dist - a.dist
                            @_movable_entity = res[ 0 ].item
                            @_may_need_snapshot = true
                            
                            if evt.ctrlKey # add / rem selection
                                @_selected.toggle_ref @_movable_entity
                                if not @_selected.contains_ref @_movable_entity
                                    delete @_movable_entity
                            else
                                @_selected.clear()
                                @_selected.push @_movable_entity
                                @_movable_entity.beg_click pos
                                
                            return true
                    
        return false

    get_movable_entities: ( res, info, pos, el ) ->
        x = pos[ 0 ]
        y = pos[ 1 ]
        proj = for p in el.points
            info.re_2_sc.proj p.pos.get()
            
        for li in el.lines when li.length == 2
            P0 = li[ 0 ].get()
            P1 = li[ 1 ].get()
            
            point = @_get_line_inter proj, P0, P1, x, y, el
            if point?
                P = [
                    el.points[ P0 ].pos[ 0 ].get() + point[ 0 ] * point[ 3 ],
                    el.points[ P0 ].pos[ 1 ].get() + point[ 1 ] * point[ 3 ],
                    el.points[ P0 ].pos[ 2 ].get() + point[ 2 ] * point[ 3 ]
                ]
                console.log "founded ", li
        
                _selected.push li
#                     os = el.points.length
# 
#                     @add_point P
#                         
#                     n = el.points[ el.points.length-1 ]
#                     ol = P1
#                     li[ 1 ]._set os
#                     el.lines.push [ os, ol ]
#                     
#                     res.push
#                         item: n
#                         dist: 0
#                         type: "Mesh"
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