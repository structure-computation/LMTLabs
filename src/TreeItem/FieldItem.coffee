#
class FieldItem extends TreeItem
    constructor: ( name = "Mesh", field = new NodalField ) ->
        super()
        
        # attributes
        @add_attr
            field: field
        
        # default values
        @_name.set name
        @_ico.set "img/mesh_24.png"
        @_viewable.set true
    
    sub_canvas_items: ->
        [ @field ]
        
    z_index: ->
        return @sub_canvas_items()[ 0 ].z_index()
