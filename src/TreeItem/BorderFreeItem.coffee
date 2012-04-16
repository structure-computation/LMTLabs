#
class BorderFreeItem extends TreeItem
    constructor: ->
        super()

        @add_attr
            border: new Border 'free'
        
        # default values
        @_name.set "Free border"
        @_ico.set "img/border_free_16.png"
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