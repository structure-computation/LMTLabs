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
        
    sub_canvas_items: ->
        [ ]