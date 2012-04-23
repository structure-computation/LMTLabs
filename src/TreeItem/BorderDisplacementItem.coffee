#
class BorderDisplacementItem extends BoundariesSelectionItem
    constructor: ( ) ->
        super()

        @add_attr
            _border_type :  'constrain_displacement'
            boundary_law :
                x : 0
                y : 0
            
        # default values
        @_name.set "Displacement boundary"
        @_ico.set "img/border_constrain_displacement_16.png"
        @_viewable.set false
        
        
    accept_child: ( ch ) ->
        ch instanceof PickedZoneItem or
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem

    sub_canvas_items: ->
        [  ]
    