#
class ScillsEdgeItem extends TreeItem
    constructor: (name = "Edge" ) ->
        super()
        
        # attributes
        @add_attr
            _mesh        : new Mesh( not_editable: true )
            
        @add_attr
            visualization: @_mesh.visualization
        
        # default values
        @_name.set name
        @_ico.set "img/edge.png"
        @_viewable.set true
    
    accept_child: ( ch ) ->
        #
        
    z_index: ->
        @_mesh.z_index()
    
    sub_canvas_items: ->
        [ ]