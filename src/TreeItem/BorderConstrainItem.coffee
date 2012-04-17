#
class BorderConstrainItem extends TreeItem
    constructor: ( constrain_type = "constrain_displacement" ) ->
        super()

        @add_attr
            border       : new Border constrain_type
            boundary_law :
                x : 0
                y : 0
            
        # default values
        @_name.set "Constrain boundary"
        @_ico.set "img/border_constrain_16.png"
        @_viewable.set true
        
        
    accept_child: ( ch ) ->
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem
        
    sub_canvas_items: ->
        [ @border ]
        
    on_mouse_down: ( cm, evt, pos, b ) ->
        @border.on_mouse_down cm, evt, pos, b
                
    on_mouse_move: ( cm, evt, pos, b ) ->
        @border.on_mouse_move cm, evt, pos, b
    