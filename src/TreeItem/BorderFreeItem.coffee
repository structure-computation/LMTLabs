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
                
    sub_canvas_items: ->
        [ ]
    