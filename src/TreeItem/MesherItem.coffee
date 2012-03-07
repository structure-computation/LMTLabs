#
class MesherItem extends TreeItem
    constructor: ( name = "Mesher" ) ->
        super()
        
        # attributes
        @add_attr
            cell_type  : new Choice( 0, [ "Triangle 3", "Triangle 6", "Quad 4",  "Quad 8" ] )
            size_X     : 8
            size_Y     : 8
            link       : true
            _mesh      : new Mesh
            point      : new Button "Add Point"
            density    : 16
            radius     : 48
            mesh       : new Button "Start Mesh", "Doing the Mesh (click to abort)"
        
        @mesh.change_allowed = ( state ) ->
            state or confirm "Are you sure you want to abort ?"
            
        # default values
        @_name.set name
        @_ico.set "img/mesher.png"
        @_viewable.set true
    
    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof MesherItem or 
        ch instanceof SketchItem or 
        ch instanceof ImgItem or
        ch instanceof TransformItem
        
    sub_canvas_items: ->
        [ @_mesh ]
        
    disp_only_in_model_editor: ->
#         @mesh
