#
class MeshItem extends TreeItem
    constructor: ( legend = undefined ) ->
        super()
        
        # attributes
        @add_attr
            mesh_item: new Mesh
        
        # default values
        @_name.set "Displacement"
        @_ico.set "img/displacement_16.png"
        @_viewable.set true
        
        @add_context_modules  new TreeAppModule_Mesher   
        @add_context_modules  new TreeAppModule_Sketch
        @add_context_modules  new TreeAppModule_Transform

    accept_child: ( ch ) ->
        ch instanceof SketchItem or
        ch instanceof ImgItem

    z_index: ->
        #could call z_index() of child
        
    sub_canvas_items: ->
        [ @mesh_item ]

    # use on directory when browsing
    get_file_info: ( info ) ->
        info.model_type = "Mesh"
        info.icon = "mesh"
