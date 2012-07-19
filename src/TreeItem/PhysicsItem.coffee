#
class PhysicsItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Physics"
        @_ico.set "img/physics_16.png"
        @_viewable.set false
        
        @add_child new MaterialItem
    
    accept_child: ( ch ) ->
        ch instanceof MaterialItem or
        ch instanceof PickedZoneItem or
        ch instanceof MaskItem or 
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem or 
        ch instanceof ImgSetItem or
        ch instanceof ImgItem or
        ch instanceof BoundariesSelectionItem
                
        
    sub_canvas_items: ->
        []
    
