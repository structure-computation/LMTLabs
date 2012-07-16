#
class BorderStrainItem extends BoundariesSelectionItem
    constructor: ( ) ->
        super()

        @add_attr
            _border_type : 'constrain_strain'
            boundary_law :
                Strain     : 0
            
        # default values
        @_name.set "Strain boundary"
        @_ico.set "img/border_constrain_strain_16.png"
        @_viewable.set false
        
    sub_canvas_items: ->
        [ ]