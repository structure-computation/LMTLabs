#
class PickedZoneItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Picked Zone"
        @_ico.set "img/zone_16.png"
        @_viewable.set true
        # attributes
        @add_attr
            # geometry
            points           : new Lst_Point
            lines            : new Lst
    
    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem or 
        ch instanceof ImgSetItem or
        ch instanceof ImgItem
                
        
    sub_canvas_items: ->
        []
    
    draw: ( info ) ->
        console.log info