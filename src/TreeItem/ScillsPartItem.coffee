#
class PartItem extends TreeItem
    constructor: (name = "Part" ) ->
        super()
        
        # attributes
        @add_attr
            gravity_center: 2
        
        # default values
        @_name.set name
        @_ico.set "img/part.png"
        @_viewable.set false
    
    accept_child: ( ch ) ->
        ch instanceof MeshItem

    z_index: ->
        #
         
    sub_canvas_items: ->
        [ ]
        
