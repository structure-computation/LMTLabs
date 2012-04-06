#
class PickedZoneItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Physics"
        @_ico.set "img/cutting_plan.png"
        @_viewable.set false
        
        @add_child new MaterialItem
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
    
