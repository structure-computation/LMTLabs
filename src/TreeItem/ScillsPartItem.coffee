#
class ScillsPartItem extends TreeItem
    constructor: (name = "Part" ) ->
        super()
        
        # attributes    
        @add_attr
            _mesh        : new Mesh( not_editable: true )
            
        @add_attr
            visualization: @_mesh.visualization
        
        # default values
        @_name.set name
        @_ico.set "img/part.png"
        @_viewable.set true
    
    #cosmetic_attribute: ( name ) ->
    #    super( name ) or ( name in [ "_mesh", "visualization" ] )    
        
    accept_child: ( ch ) ->
        ch instanceof SketchItem or
        ch instanceof MeshItem

    z_index: ->
        @_mesh.z_index()
         
    sub_canvas_items: ->
        []
        
