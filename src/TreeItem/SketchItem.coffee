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
        
        @add_action_modules  new TreeAppModule_Mesher   
        @add_action_modules  new TreeAppModule_Sketch
        @add_action_modules  new TreeAppModule_Transform
    
    accept_child: ( ch ) ->
        false
        
    sub_canvas_items: ->
        [ @mesh ]
        
    z_index: ->
        return @sub_canvas_items()[ 0 ].z_index()
        
    disp_only_in_model_editor: ->
        @mesh

    get_movable_entities: ( res, info, pos, phase, dry = false ) ->
        @mesh.get_movable_entities res, info, pos, phase, dry
        
    contextual_actions: ( res, module ) ->
        for act in module when act.ctx_act() == true
            res.push act
            
#     on_mouse_down: ( cm, evt, pos, b ) ->
#         for m in @sub_canvas_items() when m instanceof Mesh
#             m.on_mouse_down cm, evt, pos, b
#         return false
        
    _closest_point_closer_than: ( proj, pos, dist ) ->
        for m in @sub_canvas_items() when m instanceof Mesh
            m._closest_point_closer_than proj, pos, dist