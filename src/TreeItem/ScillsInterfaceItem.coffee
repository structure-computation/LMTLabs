#
class ScillsInterfaceItem extends TreeItem
    constructor: (name = "Interface" ) ->
        super()
        
        # attributes
        @add_attr
            gravity_center: 2
        
        # default values
        @_name.set name
        @_ico.set "img/interface.png"
        @_viewable.set false
    
    accept_child: ( ch ) ->
        #
        
    z_index: ->
        #    
    
    sub_canvas_items: ->
        [ ]