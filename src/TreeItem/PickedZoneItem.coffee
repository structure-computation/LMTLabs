#
class PickedZoneItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Picked Zone"
        @_ico.set "img/zone_16.png"
        @_viewable.set false
        # attributes
#         @add_attr
            #
    
    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem or 
        ch instanceof ImgSetItem or
        ch instanceof ImgItem
                
        
    sub_canvas_items: ->
        []
    
