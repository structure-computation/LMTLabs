#
class BorderStrainItem extends BoundariesSelectionItem
    constructor: ( ) ->
        super()

        @add_attr
            border       : new Border 'constrain_strain'
            boundary_law :
                Strain     : 0
            
        # default values
        @_name.set "Strain boundary"
        @_ico.set "img/border_constrain_strain_16.png"
        @_viewable.set true
        
        
    accept_child: ( ch ) ->
        ch instanceof PickedZoneItem or
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem

    sub_canvas_items: ->
        [ ]