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
            points           : [] # contains model_id of points in mesh child
            picked_element   : [] # contains item mesh and element
            _pelected        : [] # contains pre_selected element
    
    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem or 
        ch instanceof ImgSetItem or
        ch instanceof ImgItem
        
    cosmetic_attribute: ( name ) ->
        super( name ) or ( name in [ "_pelected" ] )
        
    sub_canvas_items: ->
        [ ]
        
    z_index: ->
        return 1000

    
    draw: ( info ) ->
        for pe in @picked_element
            mesh = pe.mesh
            elem = pe.element
            proj = for p in mesh.points
                info.re_2_sc.proj p.pos.get()
            #             if elem in @_pelected
            #                 elem.draw info, mesh, proj, true, info.theme.selected_lines
            #             else
            #alert (elem.constructor)
            elem.draw info, mesh, proj, true
    
    closest_point_closer_than: ( best, info, pos ) ->
        for pe in @picked_element
            mesh = pe.mesh
            elem = pe.element
            proj = for p in mesh.points
                info.re_2_sc.proj p.pos.get()
            elem.closest_point_closer_than best, mesh, proj, info, pos
            
            #add information of current picked_zone_item in best
            if best.disp?
                best.pzi = this
                
    
    