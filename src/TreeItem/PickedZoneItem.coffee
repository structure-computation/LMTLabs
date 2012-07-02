#
class PickedZoneItem extends TreeItem
    constructor: (  _border_type = "#FFFFFF" ) ->
        super()
        
        # default values
        @_name.set "Picked Zone"
        @_ico.set "img/zone_16.png"
        @_viewable.set true
        # attributes
        @add_attr
            # geometry
            _border_type     : _border_type
            points           : new Lst # contains model_id of points in mesh child
            lines            : new Lst # contains model_id of lines in mesh child
            _pelected        : new Lst # contains model_id of points/lines/surfaces in mesh child
    
    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem or 
        ch instanceof ImgSetItem or
        ch instanceof ImgItem
                
        
    sub_canvas_items: ->
        [ ]
        
    z_index: ->
        return 1000
    
    draw: ( info ) ->
        mesh = @_children[ 0 ].mesh
        if @_border_type.get() == 'constrain_displacement'
            beg_ctx = info.theme.constrain_boundary_displacement.beg_ctx
            draw_proj = info.theme.constrain_boundary_displacement.draw_proj
            end_ctx = info.theme.constrain_boundary_displacement.end_ctx

        else if @_border_type.get() == 'constrain_strain'
            beg_ctx = info.theme.constrain_boundary_strain.beg_ctx
            draw_proj = info.theme.constrain_boundary_strain.draw_proj
            end_ctx = info.theme.constrain_boundary_strain.end_ctx

        else if @_border_type.get() == 'constrain_pressure'
            beg_ctx = info.theme.constrain_boundary_pressure.beg_ctx
            draw_proj = info.theme.constrain_boundary_pressure.draw_proj
            end_ctx = info.theme.constrain_boundary_pressure.end_ctx

        else if @_border_type.get() == 'free'
            beg_ctx = info.theme.free_boundary.beg_ctx
            draw_proj = info.theme.free_boundary.draw_proj
            end_ctx = info.theme.free_boundary.end_ctx
            
        proj = for p in mesh.points
            info.re_2_sc.proj p.pos.get()
            
        lines = []
        for l in mesh.lines
            if l.model_id in @lines.get()
                lines.push l
                
        # draw lines
        for l, j in lines when l.length == 2
            if l in @_pelected
                beg_ctx info # TODO add a selected line theme for every kind of border
                draw_proj info, proj[ l[ 0 ].get() ][ 0 ], proj[ l[ 0 ].get() ][ 1 ]
                end_ctx info
            else
                beg_ctx info
                draw_proj info, proj[ l[ 0 ].get() ][ 0 ], proj[ l[ 0 ].get() ][ 1 ]
                end_ctx info
            
    get_movable_entities: ( res, info, pos, phase, dry = true ) ->
        new_res = []
        if @_children[ 0 ] instanceof SketchItem and @_children[ 0 ].mesh.get_movable_entities?
            @_children[ 0 ].get_movable_entities new_res, info, pos, phase, dry
            
            # delete movable entities who are in mesh but not in picked zone item
            if new_res.length
                l = new_res.length
                for i in [ l - 1 .. 0 ]
                    touched_elem = new_res[ i ]
                    if touched_elem.item[ 0 ].model_id not in @lines.get()
                        new_res.splice i, 1
                        
            #add information of current picked_zone_item in res
            if new_res.length > 0
                for touched in new_res
                    touched.pzi = this
        for added_res in new_res
            res.push added_res
    