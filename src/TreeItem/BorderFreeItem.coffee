#
class BorderFreeItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Free border"
        @_ico.set "img/border_free_16.png"
        @_viewable.set true

    accept_child: ( ch ) ->
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem
        
    sub_canvas_items: ->
        [  ]
