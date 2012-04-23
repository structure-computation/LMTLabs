#
class BorderFreeItem extends BoundariesSelectionItem
    constructor: ->
        super()

        @add_attr
            _border_type: 'free'
        
        # default values
        @_name.set "Free boundary"
        @_ico.set "img/border_free_16.png"
        @_viewable.set false
        
    accept_child: ( ch ) ->
        ch instanceof PickedZoneItem or
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem
        
    sub_canvas_items: ->
        [ ]
    