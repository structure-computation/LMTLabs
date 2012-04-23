#
class BorderPressureItem extends BoundariesSelectionItem
    constructor: ( ) ->
        super()

        @add_attr
            _border_type : 'constrain_pressure'
            boundary_law :
                Pressure   : 0
            
        # default values
        @_name.set "Pressure boundary"
        @_ico.set "img/border_constrain_pressure_16.png"
        @_viewable.set false
        
        
    accept_child: ( ch ) ->
        ch instanceof PickedZoneItem or
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem

    sub_canvas_items: ->
        [ ]