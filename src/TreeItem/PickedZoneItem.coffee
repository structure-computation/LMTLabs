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
            lines            : new Lst # contains model_id of points in mesh child
    
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
        return 1
    
    draw: ( info ) ->
        mesh = @_children[ 0 ].mesh
        if @_border_type.get() == 'constrain_displacement'
            color_line = info.theme.constrain_boundary_displacement.to_hex()
        else if @_border_type.get() == 'constrain_strain'
            color_line = info.theme.constrain_boundary_strain.to_hex()
        else if @_border_type.get() == 'constrain_pressure'
            color_line = info.theme.constrain_boundary_pressure.to_hex()
        else if @_border_type.get() == 'free'
            color_line = info.theme.free_boundary.to_hex()
            
        info.ctx.strokeStyle = color_line
#         proj = []
#         for p in mesh.points
#             if p.model_id in @points.get()
#                 proj.push info.re_2_sc.proj p.pos.get()

        proj = for p in mesh.points
            info.re_2_sc.proj p.pos.get()
            
        lines = []
        for l in mesh.lines
            if l.model_id in @lines.get()
                lines.push l
                
        # draw lines
        for l, j in lines when l.length == 2
#             if l in @_pre_sele
#                 info.ctx.lineWidth = 2
#             else
            
            info.ctx.lineWidth = 1
            info.ctx.beginPath()
            info.ctx.moveTo proj[ l[ 0 ].get() ][ 0 ], proj[ l[ 0 ].get() ][ 1 ]
            info.ctx.lineTo proj[ l[ 1 ].get() ][ 0 ], proj[ l[ 1 ].get() ][ 1 ]
            info.ctx.stroke()
            
    #TODO use only ref in @points, @lines instead of all mesh @lines/@points
    get_movable_entities: ( res, info, pos, phase, dry ) ->
        if @_children[ 0 ] instanceof SketchItem and @_children[ 0 ].mesh.get_movable_entities?
            @_children[ 0 ].get_movable_entities res, info, pos, phase, dry
    
    