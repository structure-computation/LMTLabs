#
class SketchItem extends TreeItem
    constructor: ( name = "Mesh" ) ->
        super()
        
        # attributes
        @add_attr
            mesh: new Mesh
        
        # default values
        @_name.set name
        @_ico.set "img/mesh_24.png"
        @_viewable.set true
    
    accept_child: ( ch ) ->
        false
        
    sub_canvas_items: ->
        [ @mesh ]
        
    disp_only_in_model_editor: ->
        @mesh

    get_movable_entities: ( res, info, pos, phase, dry = false ) ->
        @mesh.get_movable_entities res, info, pos, phase, dry