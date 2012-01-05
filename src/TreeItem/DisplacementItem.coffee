#
class DisplacementItem extends TreeItem
    constructor: ( app ) ->
        super()
        
        
        # attributes
        @add_attr
            legend      : new Legend "Displacement X"
            
        @add_attr
            displacement: new Displacement app, @legend
            
        # default values
        @_name.set "Displacement"
        @_ico.set "img/displacement_16.png"
        @_viewable.set true

        
    accept_child: ( ch ) ->
        ch instanceof SketchItem or
        ch instanceof ImgItem

    z_index: ->
        #could call z_index() of child
        
    sub_canvas_items: ->
        [ @displacement, @legend ]
